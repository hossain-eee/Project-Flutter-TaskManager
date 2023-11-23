import 'package:get/get.dart';
import 'package:module_11_class_3/data/models/task_list_model.dart';

import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class CompletedTaskController extends GetxController {
  //flag
  bool _completedTaskIsInProgress = false;
  //model class instance
  TaskListModel _taskListModel = TaskListModel();
  //getter
  bool get completedTaskIsInProgress => _completedTaskIsInProgress;
  TaskListModel get taskListModel => _taskListModel;
  //get api
  Future<void> getCompletedTask() async {
    _completedTaskIsInProgress = true;
    update();
    NetworkResponse response =
        await NetworkCaller().getRequest(Urls.completedTask);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);
    } else {
      Get.snackbar('Failed', "Completed task get failed");
    }
    _completedTaskIsInProgress = false;
    update();
  }

  //delete task api calling
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
