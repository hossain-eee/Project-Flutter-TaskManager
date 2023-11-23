import 'package:flutter/material.dart';
import 'package:module_11_class_3/data/models/task_list_model.dart';
import 'package:module_11_class_3/ui/screens/updat_task_status_sheet.dart';
import 'package:module_11_class_3/ui/widgets/task_list_tile.dart';
import 'package:module_11_class_3/ui/widgets/user_profile_banner.dart';
import 'package:get/get.dart';

import '../state_managers/completed_task_controller.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  final CompletedTaskController _completedTaskController =
      Get.find<CompletedTaskController>();


  //update task status
  void showStatusUpdateBottomSheet(TaskData task) {
    //our data inside  TaskData sub-class of TaskListModel class, that is why parameter is TaskData type

    showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return UpdateTaskStatusSheet(
            task: task,
            onUpdate: () {
              Get.back();
              _completedTaskController
                  .getCompletedTask(); // update data from server by get method
            },
          );
        });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _completedTaskController.getCompletedTask();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const UserProfileAppBar(
              isUpdateProfileScreen: false,
            ),
            Expanded(
              child: _completedTaskController.completedTaskIsInProgress
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : GetBuilder<CompletedTaskController>(
                    builder: (completedTaskController) {
                      return ListView.separated(
                          itemBuilder: (context, index) {
                            return TaskListTile(
                              data: completedTaskController.taskListModel.data![index],
                              color: Colors.green,
                              //just call these mehtod to avoid error, because we give these two callback method to TaskListTile() widget as parameter
                              onDeleteTap: () {
                                completedTaskController.deleteTask(completedTaskController.taskListModel.data![index].sId!);
                              },
                              onEditTap: () {
                                showStatusUpdateBottomSheet(
                                    completedTaskController.taskListModel.data![index]);
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(
                              height: 4,
                            );
                          },
                          itemCount: completedTaskController.taskListModel.data?.length ?? 0,
                        );
                    }
                  ),
            )
          ],
        ),
      ),
    );
  }
}
