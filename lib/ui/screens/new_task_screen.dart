import 'package:flutter/material.dart';
import 'package:module_11_class_3/data/models/task_list_model.dart';
import 'package:module_11_class_3/ui/screens/add_new_task_screen.dart';
import 'package:module_11_class_3/ui/screens/updat_task_status_sheet.dart';
import 'package:module_11_class_3/ui/screens/update_task_bottom_sheet_screen.dart';
import 'package:module_11_class_3/ui/state_managers/delete_task_controller.dart';
import 'package:module_11_class_3/ui/state_managers/new_task_controller.dart';
import 'package:module_11_class_3/ui/state_managers/summary_count_controller.dart';
import 'package:module_11_class_3/ui/widgets/summary_card.dart';
import 'package:module_11_class_3/ui/widgets/task_list_tile.dart';
import 'package:module_11_class_3/ui/widgets/user_profile_banner.dart';
import 'package:get/get.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  //controller find, because here we need controller data inside initState()
  final SummaryCountController _summaryCountController =
      Get.find<SummaryCountController>();
  final NewTaskController _newTaskController = Get.find<NewTaskController>();
  @override
  void initState() {
    super.initState();
/* in our getCountSummary() we called setState(), but initState() called first,
 so when getCountSummary() called try to setState() but still we have not build, build() method that's an error.
    so called WidgetsBinding.instance.addPostFrameCallback() ,
    WidgetsBinding.instance.addPostFrameCallback() is a method in Flutter that allows you to register a callback function to be executed 
    after the current frame has been rendered. This means that the callback will run once all widgets have been built and rendered on the screen during the frame.
    */
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _summaryCountController.getCountSummary(); //from controller
      _newTaskController.getNewTask(); //from controller
    });
  }

  //Edit Task, but there is no api, ostad server don't have this api to update task, but need to learn it
  void showEditBottomSheet(TaskData task) {
    //our data inside  TaskData sub-class of TaskListModel class, that is why parameter is TaskData type
    showModalBottomSheet(
        // isDismissible: false,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Builder(builder: (_) {
            return UpdateTaskSheet(
              task: task,
              //callback function, will perform operation when it will triggered
              onUpdate: () {
                _newTaskController
                    .getNewTask(); // again get getNewTask() to updated value from server
              },
            );
          });
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
          return GetBuilder<NewTaskController>(builder: (_) {
            return UpdateTaskStatusSheet(
              task: task,
              onUpdate: () {
                Get.back(); // its necessary UpdateTaskStatusSheet() widget button click for close bottom sheet
                _newTaskController
                    .getNewTask(); // update data from server by get method
                _summaryCountController.getCountSummary();// to update summary card when change status of task
              },
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddNewTaskScreen());
          /*  Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewTaskScreen(),
            ),
          ); */
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const UserProfileAppBar(
              isUpdateProfileScreen: false,
            ),
            //summary count
            GetBuilder<SummaryCountController>(builder: (_) {
              if (_summaryCountController.getCountSummaryInProgress) {
                return const Center(
                  child: LinearProgressIndicator(),
                );
              }
              return _summaryCountController.noDataReceive ==
                      false //when data loading successful
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          height: 80,
                          width: double.infinity,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return SummaryCard(
                                  number: _summaryCountController
                                          .summaryCountModel.data![index].sum ??
                                      0,
                                  title: _summaryCountController
                                          .summaryCountModel.data![index].sId ??
                                      'New');
                            },
                            separatorBuilder: (context, index) {
                              return const Divider(
                                height: 4,
                              );
                            },
                            itemCount: _summaryCountController
                                    .summaryCountModel.data?.length ??
                                0,
                          )),
                    )
                  : Text(
                      //when data fetching error
                      _summaryCountController.message,
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                    );
            }),
            /*##################### New Task #############################*/
            // Expanded() for take all the availabe space, without Expanded() render flex error will show because top has a Row(). without Expanded, we can set fixed height by Container() or SizedBox()
            Expanded(
              child: GetBuilder<NewTaskController>(builder: (_) {
                //The RefreshIndicator() widget is a Material widget that allows you to add a pull-to-refresh gesture to your Flutter app.
                return RefreshIndicator(
                  onRefresh: () async {
                    _newTaskController.getNewTask(); //refresh NewTask list
                    _summaryCountController
                        .getCountSummary(); // refresh Summary Card() count
                  },
                  child: _newTaskController.getNewTaskInProgress
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : _newTaskController.dataLoadingError ==
                              false //when data loading successful
                          ? GetBuilder<DeleteTaskController>(
                              builder: (deleteTaskController) {
                              return ListView.separated(
                                itemBuilder: (context, index) {
                                  return TaskListTile(
                                    data: _newTaskController
                                            .taskListModel.data![
                                        index], //this index will work inside task_list_tile.dart file
                                    color: Colors.blue,
                                    onDeleteTap: () {
                                      deleteTaskController.deleteTask(
                                          _newTaskController
                                              .taskListModel.data![index].sId!);
                                      _summaryCountController
                                          .getCountSummary(); //update summary card
                                    },
                                    onEditTap: () {
                                      // showEditBottomSheet(_taskListModel.data![index]);// edit task, api is not provided
                                      showStatusUpdateBottomSheet(
                                          _newTaskController
                                                  .taskListModel.data![
                                              index]); // update task status
                                    },
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const Divider(
                                    height: 4,
                                  );
                                },
                                itemCount: _newTaskController
                                        .taskListModel.data?.length ??
                                    0, // if 0, then no item will be display, that mean it will not go into list
                              );
                            })
                          : Text(
                              //when data loading fail
                              _newTaskController.message,
                              style: TextStyle(
                                  fontSize: 18, color: Colors.red.shade300),
                            ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
