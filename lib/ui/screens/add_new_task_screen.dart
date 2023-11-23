import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:module_11_class_3/ui/widgets/screen_background.dart';
import 'package:module_11_class_3/ui/widgets/user_profile_banner.dart';

import '../state_managers/add_new_task_controller.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  //controller
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScreenBackground(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const UserProfileAppBar(
                  isUpdateProfileScreen: false,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Add New Task",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _titleTEController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                              hintText: 'Subject',
                              hintStyle: TextStyle(color: Colors.grey)),
                          validator: (String? value) {
                            if (value?.isEmpty ?? true) {
                              return 'Enter Task title';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: _descriptionTEController,
                          keyboardType: TextInputType.text,
                          maxLines: 4,
                          decoration: const InputDecoration(
                              hintText: 'Description',
                              hintStyle: TextStyle(color: Colors.grey)),
                          validator: (String? value) {
                            if (value?.isEmpty ?? true) {
                              return 'Enter Task Description';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        //button for submit
                        GetBuilder<AddNewTaskController>(
                            builder: (addNewTaskController) {
                          return SizedBox(
                            width: double.infinity,
                            child: Visibility(
                              visible:
                                  addNewTaskController.adNewTaskInProgress ==
                                      false,
                              replacement: const Center(
                                child: CircularProgressIndicator(),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  addNewTaskController
                                      .addNewTask(
                                          _titleTEController.text.trim(),
                                          _descriptionTEController.text.trim())
                                      .then((value) {
                                    if (value) {
                                      _titleTEController.clear();
                                      _descriptionTEController.clear();
                                      if (mounted) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Yeah,Task Added Successfully')));
                                      }
                                    }
                                  });
                                },
                                child: const Icon(Icons.arrow_forward_ios),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
