import 'package:flutter/material.dart';
import 'package:module_11_class_3/data/models/task_list_model.dart';
import 'package:module_11_class_3/ui/screens/updat_task_status_sheet.dart';
import 'package:module_11_class_3/ui/widgets/task_list_tile.dart';
import 'package:module_11_class_3/ui/widgets/user_profile_banner.dart';
import '../state_managers/in_progress_task_controller.dart';
import 'package:get/get.dart';

class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({super.key});

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {
  final InProgressTaskController _inProgressTaskController =
      Get.find<InProgressTaskController>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _inProgressTaskController.getInProgressTasks();
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
              Get.back(); //necessary for close bottomsheet when button click, becase its callback
              _inProgressTaskController
                  .getInProgressTasks(); // update data from server by get method
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

            // Expanded() for tak all the availabe space, without Expanded() render flex error will show because top has a Row(). without Expanded, we can set fixed height by Container() or SizedBox()
            Expanded(
              child: _inProgressTaskController.getProgressTaskInProgress
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : GetBuilder<InProgressTaskController>(
                      builder: (inProgressTaskController) {
                      return ListView.separated(
                          itemBuilder: (context, index) {
                            return TaskListTile(
                              data: inProgressTaskController
                                      .taskListModel.data![
                                  index], //when it entered in list so oviously it has data
                              color: const Color.fromARGB(255, 203, 12, 159),
                              //just call these mehtod to avoid error, because we give these two callback method to TaskListTile() widget as parameter
                              onDeleteTap: () {
                                inProgressTaskController
                                    .deleteTask(inProgressTaskController
                                        .taskListModel.data![index].sId!)
                                    .then((value) {
                                  if (value) {
                                    if (mounted) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Data has been Deleted")));
                                    }
                                  }
                                });
                              },
                              onEditTap: () {
                                showStatusUpdateBottomSheet(
                                    inProgressTaskController
                                        .taskListModel.data![index]);
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(
                              height: 4,
                            );
                          },
                          //if data is empty then 0 that mean no item will display
                          itemCount: inProgressTaskController
                                  .taskListModel.data?.length ??
                              0);
                    }),
            )
          ],
        ),
      ),
    );
  }
}
