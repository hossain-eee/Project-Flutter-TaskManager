import 'dart:developer';

import 'package:get/get.dart';
import 'package:module_11_class_3/data/models/network_response.dart';
import 'package:module_11_class_3/data/models/task_list_model.dart';

import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class CancelledTaskController extends GetxController {
  //flag
  bool _canccelledTaskIsInProgress = false;
  //model class instance
  TaskListModel _taskListModel = TaskListModel();

  //getter
  bool get canccelledTaskIsInProgress => _canccelledTaskIsInProgress;
  TaskListModel get taskListModel => _taskListModel;

  //api calling
  Future<void> getCancelledTask() async {
    _canccelledTaskIsInProgress = true;
    update();
    NetworkResponse response =
        await NetworkCaller().getRequest(Urls.cancelledTask);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);
      print("model class data: ${_taskListModel.data}");
      print("model class data length: ${_taskListModel.data!.length}");
      log(_taskListModel.data.toString());
    } else {
      Get.snackbar('Failed', 'Cancelled task get failed');
    }
    _canccelledTaskIsInProgress = false;
    update();
  }

  //delete task
  Future<void> deleteTask(String taskId) async {
    final NetworkResponse response = await NetworkCaller().getRequest(
      Urls.deleteTask(taskId),
    );
    if (response.isSuccess) {
      // getNewTask();// Again api calling to update data
      /* after delete(because if condition is true),getNewTask() will recalled the api to update task list. 
      But every time called api there is cost(money) behind it. 
      so make cost effecttive we just remove data from our list and update state by setState() that's enough to update data, 
      and behind the scene data also delete from server by api callig so its also updated data wihtout calling api */

      //delete from our list, and list is inside our model class where we store api data
      _taskListModel.data!.removeWhere((element) => element.sId == taskId);
      update();
    } else {
      Get.snackbar("Failed", "Deletion of task has been failed");
    }
  }
}
