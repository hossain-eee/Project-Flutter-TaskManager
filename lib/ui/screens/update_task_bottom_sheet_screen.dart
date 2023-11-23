import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:module_11_class_3/data/models/network_response.dart';
import 'package:module_11_class_3/data/models/task_list_model.dart';
import 'package:module_11_class_3/data/utils/urls.dart';

import '../../data/services/network_caller.dart';

//there is no option to update task in ostad server, its only for practice
class UpdateTaskSheet extends StatefulWidget {
  final TaskData task;
  final VoidCallback
      onUpdate; // we need a callback function to response by user click

  const UpdateTaskSheet(
      {super.key, required this.task, required this.onUpdate});

  @override
  State<UpdateTaskSheet> createState() => _UpdateTaskSheetState();
}

class _UpdateTaskSheetState extends State<UpdateTaskSheet> {
  late TextEditingController _titleTEController;
  late TextEditingController _descriptionTEController;
  @override
  void initState() {
    //we want show/get controller text data when this page is load, that's why controller insie this method
    super.initState();
    _titleTEController = TextEditingController(text: widget.task.title);
    _descriptionTEController =
        TextEditingController(text: widget.task.description);
  }

  bool _updatedTaskInProgress = false;

  //update task api calling, just copy addNewTask() from add_new_task_screen and edit

  Future<void> updateTask() async {
    //here is no model class, because here we post data, not receving something so that it could store our own class.
    _updatedTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    Map<String, dynamic> requestBody = {
      "title": _titleTEController.text.trim(),
      "description": _descriptionTEController.text.trim(),
    };
    NetworkResponse response = await NetworkCaller().postRequest(
        Urls.createTask,
        requestBody); // Ostad server doesn’t provide url for update task, its extra for practice
    _updatedTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      //clear the controller
      _titleTEController.clear();
      _descriptionTEController.clear();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Task updated Successfully")));
      }
      //callback function trigger when this updateTask() is run and if condition is true
      widget
          .onUpdate(); //this callback function will perform operation where we will call this widget
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Task update Failed")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          //copy form add new task and edit
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Update Task",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        if (mounted) {
                          // Navigator.pop(context);
                          Get.back();
                        }
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                controller: _titleTEController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    hintText: 'Subject',
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: _descriptionTEController,
                keyboardType: TextInputType.text,
                maxLines: 4,
                decoration: const InputDecoration(
                    hintText: 'Description',
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
              const SizedBox(
                height: 16,
              ),
              //button for submit
              SizedBox(
                width: double.infinity,
                child: Visibility(
                  visible: _updatedTaskInProgress == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      // updateTask();//no update url, so disable it
                    },
                    child: const Text("Update"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
