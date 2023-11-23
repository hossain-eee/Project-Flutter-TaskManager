import 'package:flutter/material.dart';
import 'package:module_11_class_3/data/models/task_list_model.dart';

class TaskListTile extends StatelessWidget {
  final VoidCallback onDeleteTap, onEditTap; //callback method for delete and edit item
  final Color color;
  final TaskData data; // model class type, access data by this model class.
  const TaskListTile({
    super.key,
    required this.color,
    required this.data, 
    required this.onDeleteTap, 
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(data.title ?? 'Unknown'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data.description ?? ''),
          Text(data.createdDate ?? ''),
          Row(
            children: [
              //chip widget for colorful circular/rectangular background text looks like button
              Chip(
                label: SizedBox(
                  width: 70,
                  child: Text(
                    data.status ?? 'New',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                backgroundColor: color,
              ),

              //Spacer(), take all the availabe space, for row take horizontal and for column take vertical space
              const Spacer(),
              IconButton(
                onPressed: 
                  onDeleteTap,
                icon: Icon(
                  Icons.delete_forever,
                  color: Colors.red.shade300,
                ),
              ),
              IconButton(
                onPressed:onEditTap,
                icon: const Icon(
                  Icons.edit,
                  color: Colors.green,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
