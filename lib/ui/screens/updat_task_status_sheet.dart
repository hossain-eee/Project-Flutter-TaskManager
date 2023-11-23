import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:module_11_class_3/data/models/task_list_model.dart';
import 'package:module_11_class_3/ui/state_managers/update_task_status_controller.dart';
class UpdateTaskStatusSheet extends StatefulWidget {
  final TaskData task;
  final VoidCallback onUpdate;
  const UpdateTaskStatusSheet(
      {super.key, required this.task, required this.onUpdate});

  @override
  State<UpdateTaskStatusSheet> createState() => _UpdateTaskStatusSheetState();
}

class _UpdateTaskStatusSheetState extends State<UpdateTaskStatusSheet> {
  List<String> taskStatusList = [
    'New',
    'Progress',
    'Cancelled',
    'Completed'
  ]; //spelling and case (lower/upper) should match with api
  // List<String> taskStatusList = ['new', 'Progress', 'Canceled', 'Completed'];

  //set selected task as server provide present task status
  // String selectedTask = task.status!.toLowerCase(); // by this don't match with server name becoz first name is capital and here we make all small
  late String selectedTask;
  bool updateTaskInProgress = false;
  late UpdateTaskStatusController _updateTaskStatusController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedTask = widget.task.status!;
    _updateTaskStatusController =
        Get.put(UpdateTaskStatusController(onUpdate: widget.onUpdate));
  }

  @override
  Widget build(BuildContext context) {
    //updateState is random name, works for change state
    return SizedBox(
      height: 450,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Text(
                  "Update Status",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      // Navigator.pop(context);
                      Get.back();
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return GetBuilder<UpdateTaskStatusController>(
                  builder: (updateTaskStatusController) {
                    return ListTile(
                      onTap: () {
                        selectedTask = taskStatusList[
                            index]; //now selected Task will be decided by user by click
                        // setState(() {});
                        updateTaskStatusController.updateState(); //getx controller method created instead of setState(() {})
                      },
                      title: Text(taskStatusList[index].toUpperCase()),
                      trailing: selectedTask == taskStatusList[index]
                          ? const Icon(Icons.check)
                          : null, //match name will have check box other nothing just null
                    );
                  }
                );
              },
              itemCount: taskStatusList.length,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Visibility(
              visible: updateTaskInProgress == false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: GetBuilder<UpdateTaskStatusController>(
                  builder: (updateTaskStatusController) {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        updateTaskStatusController
                            .updateTaskStatus(widget.task.sId!, selectedTask)
                            .then((value) {
                          if (value) {
                            widget.onUpdate();
                            Get.snackbar('Success',
                                'Update task status has been Successful');
                            // Navigator.pop(context);
                            Get.back();
                          }
                        });
                      },
                      child: const Text('Update')),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
