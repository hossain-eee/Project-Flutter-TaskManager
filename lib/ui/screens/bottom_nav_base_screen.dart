import 'package:flutter/material.dart';
import 'package:module_11_class_3/ui/screens/cancelled_task_screen.dart';
import 'package:module_11_class_3/ui/screens/completed_task_screen.dart';
import 'package:module_11_class_3/ui/screens/in_progress_task_screen.dart';
import 'package:module_11_class_3/ui/screens/new_task_screen.dart';

class BottomNavBaseScreen extends StatefulWidget {
  const BottomNavBaseScreen({super.key});

  @override
  State<BottomNavBaseScreen> createState() => _BottomNavBaseScreenState();
}

class _BottomNavBaseScreenState extends State<BottomNavBaseScreen> {
  int _selectedScreenIndex = 0;

  //screen which will be load by bottom navigation click
  final List<Widget> _screen = const [
    NewTaskScreen(),
    InProgressTaskScreen(),
    CancelledTaskScreen(),
    CompletedTaskScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen[_selectedScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedScreenIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: const TextStyle(color: Colors.grey),
        showUnselectedLabels: true, // to display unselected label text
        onTap: (value) {
          if (mounted) {
            //here is only one setState() so no need to convert into getx, if setState is 5/10 times then for performance issue convert into getx
            setState(() {
              _selectedScreenIndex = value;
            });
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.task_outlined), label: 'New Task'),
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: 'Progress'),
          BottomNavigationBarItem(
              icon: Icon(Icons.cancel_outlined), label: 'Cancelled'),
          BottomNavigationBarItem(
              icon: Icon(Icons.done_all_sharp), label: 'Completed'),
        ],
      ),
    );
  }
}
