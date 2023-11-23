import 'package:get/get.dart';

import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class AddNewTaskController extends GetxController {
  //task progress for hide subbmit button
  bool _adNewTaskInProgress = false;
  //getter
  bool get adNewTaskInProgress => _adNewTaskInProgress;

  Future<bool> addNewTask(String title, String description) async {
    //here is no model class, because here we post data, not receving something so that it could store our own class.
    _adNewTaskInProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "title": title,
      "description": description,
      "status": "New"
    };
    NetworkResponse response =
        await NetworkCaller().postRequest(Urls.createTask, requestBody);
    _adNewTaskInProgress = false;
    update();
    if (response.isSuccess) {
      //clear the controller
     /*  _titleTEController.clear();
      _descriptionTEController.clear();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Task Added Successfully")));
       
      } */
       return true;
    } else {
      Get.snackbar('Failed', "Task  add Failed");
      return false;
    }
  }
}
