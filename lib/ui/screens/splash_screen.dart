import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:module_11_class_3/data/models/auth_utility.dart';
import 'package:module_11_class_3/ui/screens/auth/login_screen.dart';
import 'package:module_11_class_3/ui/screens/bottom_nav_base_screen.dart';
import 'package:module_11_class_3/ui/utils/assets.utils.dart';
import 'package:module_11_class_3/ui/widgets/screen_background.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //apply the method so that show splash screen for 3 seconds and then go login screen
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigateToLogin();
  }

  //navigate to login screen after 3 second of showing splash screen
  void navigateToLogin() {
    //if use await then use async in method (void navigateToLogin() async{})
    // await Future.delayed(Duration(seconds: 4));
    // Navigator.pushAndRemoveUntil(
    //   context,
    //   MaterialPageRoute(builder: (context) => const LoginScreen()),
    //       (route) => false,
    // );
    Future.delayed(
      const Duration(seconds: 3),
    ).then((_) async {
      //check user is login or not, then show 3 sec splash screen,then if loggedIn then BottomNavBaseScreen() else LoginScreen()
      final bool isLoggedIn = await AuthUtility.checkUserLoggedIn();

      if (mounted) {
        Get.offAll(
          () => isLoggedIn ? const BottomNavBaseScreen() : const LoginScreen(),
        );
        /*   Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return isLoggedIn?  const BottomNavBaseScreen() :  const LoginScreen();
      }), (route) => false); */
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScreenBackground(
          //background image is by default inside ScreenBackground() widget, so we need only logo for this splash screen
          child: Center(
            child: SvgPicture.asset(
              AssetsUtils.logoSvg,
              width: 90,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
    );
  }
}
