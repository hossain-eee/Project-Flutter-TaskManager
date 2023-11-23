import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:module_11_class_3/data/services/network_caller.dart';
import 'package:module_11_class_3/data/utils/urls.dart';

import '../../data/models/network_response.dart';

class UpdateTaskStatusController extends GetxController {
  /*  List<String> taskStatusList = [
    'New',
    'Progress',
    'Cancelled',
    'Completed'
  ]; //spelling and case (lower/upper) should match with api */
  final VoidCallback onUpdate;
  UpdateTaskStatusController({required this.onUpdate});
  bool _updateTaskInProgress = false;
  //getter method
  bool get updateTaskInProgress => _updateTaskInProgress;
  //update task status
  Future<bool> updateTaskStatus(String taskId, String newStatus) async {
    _updateTaskInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller().getRequest(
      Urls.updateTaskStatus(taskId, newStatus),
    );
    _updateTaskInProgress = false;
    update();
    if (response.isSuccess) {
      onUpdate(); // trigger callback method
      Get.snackbar('Success', 'Update task status has been Successful');
      if (_updateTaskInProgress == false) {
        // Navigator.pop(context);
        Get.back();
      }
      update();
      return true;
    } else {
      Get.snackbar('Failed', 'Update task status has been failed');
      return false;
    }
  }

//use it where need SetState() method
  void updateState() {
    update();
  }
}
