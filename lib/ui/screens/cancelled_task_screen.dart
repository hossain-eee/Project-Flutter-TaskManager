import 'package:flutter/material.dart';
import 'package:module_11_class_3/data/models/task_list_model.dart';
import 'package:module_11_class_3/ui/screens/updat_task_status_sheet.dart';
import 'package:module_11_class_3/ui/widgets/task_list_tile.dart';
import 'package:module_11_class_3/ui/widgets/user_profile_banner.dart';
import 'package:get/get.dart';

import '../state_managers/cancelled_task_controller.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  final CancelledTaskController _cancelledTaskController =
      Get.find<CancelledTaskController>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _cancelledTaskController.getCancelledTask();
    });
  }


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
              _cancelledTaskController.getCancelledTask(); // update data from server by get method
            },
          );
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
              child: _cancelledTaskController.canccelledTaskIsInProgress
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : GetBuilder<CancelledTaskController>(
                    builder: (cancelledTaskController) {
                      return ListView.separated(
                          itemBuilder: (context, index) {
                            return TaskListTile(
                              data: cancelledTaskController.taskListModel.data![
                                  index], //when enter inside list then oviously data is not empty
                              color: Colors.red,
                              //just call these mehtod to avoid error, because we give these two callback method to TaskListTile() widget as parameter
                              onDeleteTap: () {
                               cancelledTaskController.deleteTask(cancelledTaskController.taskListModel.data![index].sId!);
                              },
                              onEditTap: () {
                                showStatusUpdateBottomSheet(
                                    cancelledTaskController.taskListModel.data![index]);
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(
                              height: 4,
                            );
                          },
                          //if data is empty then 0, means no item will display
                          itemCount: cancelledTaskController.taskListModel.data?.length ?? 0);
                    }
                  ),
            )
          ],
        ),
      ),
    );
  }
}
