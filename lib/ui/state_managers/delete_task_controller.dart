import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:module_11_class_3/data/models/network_response.dart';
import 'package:module_11_class_3/data/services/network_caller.dart';
import 'package:module_11_class_3/data/utils/urls.dart';
import 'package:module_11_class_3/ui/state_managers/new_task_controller.dart';

class DeleteTaskController extends GetxController {
//we want to delete from new task data to update from our model file, so need to access new task model class, so use new task contoller to access its model class object
  final NewTaskController _newTaskController = Get.find<NewTaskController>();

  //delete task
  Future<bool> deleteTask(String taskId) async {
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
      // _taskListModel.data!.removeWhere((element) => element.sId == taskId);

      _newTaskController.taskListModel.data!.removeWhere((element) => element.sId == taskId);
      Get.snackbar("Success", 'Delegation of task has been successful',
          backgroundColor: Colors.green.shade300,
          snackPosition: SnackPosition.BOTTOM);

      update();
      return true;
    } else {
      Get.snackbar("Failed", 'Deletion of task has been failed',
      backgroundColor: Colors.red.shade300,
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }
  }
}
