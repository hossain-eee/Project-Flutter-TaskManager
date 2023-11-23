import 'package:get/get.dart';
import 'package:module_11_class_3/data/models/network_response.dart';
import 'package:module_11_class_3/data/models/task_list_model.dart';
import 'package:module_11_class_3/data/services/network_caller.dart';
import 'package:module_11_class_3/data/utils/urls.dart';

class NewTaskController extends GetxController {
  // bool _getCountSummaryInProgress = false;
  bool _getNewTaskInProgress = false;
  bool _dataLoadingError = false;
  String message = '';
  //instance of TaskListModel to update new Task data from server
  TaskListModel _taskListModel = TaskListModel();

//getter method, we don't want expose our data to user so that they can't manipulate it
  bool get getNewTaskInProgress => _getNewTaskInProgress;
  TaskListModel get taskListModel => _taskListModel;
  bool get dataLoadingError => _dataLoadingError;
  
//new task data from server (api fetch)
  Future<bool> getNewTask() async {
    _getNewTaskInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.newTask);
    _getNewTaskInProgress = false;

    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response
          .body!); //when response.isSuccess=true, then definately body has data
      update();
      return true;
    } else {
      _dataLoadingError = true;
      Get.snackbar('Failed', 'get new task data failed');
      message = "Data loading Error";
      update();
      return false;
    }
  }
}
