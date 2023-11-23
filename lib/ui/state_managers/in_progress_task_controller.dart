import 'package:get/get.dart';
import 'package:module_11_class_3/data/models/task_list_model.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class InProgressTaskController extends GetxController {
  //flag variable
  bool _getProgressTaskInProgress = false;
//instance of Model class where we will put api data
  TaskListModel _taskListModel = TaskListModel();
  //getter
  bool get getProgressTaskInProgress => _getProgressTaskInProgress;
  TaskListModel get taskListModel => _taskListModel;
// getInprogress Tasks api fetching method
  Future<void> getInProgressTasks() async {
    _getProgressTaskInProgress = true;
    update();
    NetworkResponse response =
        await NetworkCaller().getRequest(Urls.inProgressTask);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);
    } else {
      Get.snackbar('Failed', 'In progress task get failed');
    }
    _getProgressTaskInProgress = false;
    update();
  }

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
      _taskListModel.data!.removeWhere((element) => element.sId == taskId);
      
      update();
      return true;
    } else {
      Get.snackbar('Failed', "Deletion of task has been failed");
      return false;
    }
  }

  //use it where need SetState() method
  void updateState() {
    update();
  }
}
