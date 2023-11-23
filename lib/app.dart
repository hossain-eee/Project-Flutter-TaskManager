import 'package:flutter/material.dart';
import 'package:module_11_class_3/ui/screens/splash_screen.dart';
import 'package:get/get.dart';
import 'package:module_11_class_3/ui/state_managers/add_new_task_controller.dart';
import 'package:module_11_class_3/ui/state_managers/cancelled_task_controller.dart';
import 'package:module_11_class_3/ui/state_managers/completed_task_controller.dart';
import 'package:module_11_class_3/ui/state_managers/delete_task_controller.dart';
import 'package:module_11_class_3/ui/state_managers/email_validation_controller.dart';
import 'package:module_11_class_3/ui/state_managers/in_progress_task_controller.dart';
import 'package:module_11_class_3/ui/state_managers/login_controller.dart';
import 'package:module_11_class_3/ui/state_managers/new_task_controller.dart';
import 'package:module_11_class_3/ui/state_managers/otp_verification_controller.dart';
import 'package:module_11_class_3/ui/state_managers/reset_password_controller.dart';
import 'package:module_11_class_3/ui/state_managers/sign_up_controller.dart';
import 'package:module_11_class_3/ui/state_managers/summary_count_controller.dart';
import 'package:module_11_class_3/ui/state_managers/update_task_status_controller.dart';
// import 'package:module_11_class_3/ui/state_managers/update_profile_controller.dart';

import 'ui/state_managers/update_profile_controller.dart';

class TaskManagerApp extends StatefulWidget {
  const TaskManagerApp({super.key});
  static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: TaskManagerApp
          .globalKey, // for global navigation need navigatorKey for context in dart class inside NetworkCaller class
      title: "Task Management App",
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.green,

        //TextForm Decoration
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),

        //text style

        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            letterSpacing: 0.6,
          ),
        ),

        //button style
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 10),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              )),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepOrange,

        //same as normal theme, same code just copy paste, because in dark mode we also want this style but color will be change by primarySwatch
        //TextForm Decoration
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),

        //text style

        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            letterSpacing: 0.6,
          ),
        ),

        //button style
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 10),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              )),
        ),
      ),
      themeMode: ThemeMode.light,
      initialBinding: ControllerBindings(), //GetMaterialApp() properties
      home: const SplashScreen(),
    );
  }
}

//regester the controller for broadcast to full app
class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    // declared all Controller class here
    Get.put<LoginController>(LoginController());
    Get.put<SummaryCountController>(SummaryCountController());
    Get.put<NewTaskController>(NewTaskController());
    Get.put<DeleteTaskController>(DeleteTaskController());
    Get.put<UpdateProfileController>(UpdateProfileController());
    Get.put<InProgressTaskController>(InProgressTaskController());
    Get.put<EmailValidationController>(EmailValidationController());
    Get.put<CompletedTaskController>(CompletedTaskController());
    Get.put<CancelledTaskController>(CancelledTaskController());
    Get.put<AddNewTaskController>(AddNewTaskController());
    Get.put<SignUpController>(SignUpController());
    Get.put<ResetPasswordController>(ResetPasswordController());
    Get.put<OtpVerificationController>(OtpVerificationController());

    // Get.put<UpdateProfileController>(UpdateProfileController());
    // Get.put<UpdateTaskStatusController>(UpdateTaskStatusController(onUpdate: () {  }));
  }
}
