import 'package:flutter/material.dart';
import 'package:module_11_class_3/ui/screens/auth/signup_screen.dart';
import 'package:module_11_class_3/ui/screens/bottom_nav_base_screen.dart';
import 'package:module_11_class_3/ui/screens/email_verification_screen.dart';
import 'package:module_11_class_3/ui/state_managers/login_controller.dart';
import 'package:module_11_class_3/ui/widgets/screen_background.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
//text editing controller
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  //global key for form validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //get x instatiation
  // final LoginController loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScreenBackground(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 64,
                    ),
                    Text(
                      "Get Started with",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _emailTEController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email address';
                        } else if (!RegExp(
                                r'^[a-zA-Z0-9.+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+$')
                            .hasMatch(value)) {
                          return 'Invalid email address';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: _passwordTEController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    //button for submit
                    GetBuilder<LoginController>(builder: (loginController) {
                      //any name like loginController, its an object
                      return SizedBox(
                        width: double.infinity,
                        child: Visibility(
                          visible: loginController.isLoginInProgress == false,
                          replacement: const Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                //login() method called after form validation is true
                                loginController
                                    .login(_emailTEController.text.trim(),
                                        _passwordTEController.text)
                                    .then((result) {
                                  if (result == true) {
                                    Get.offAll(
                                        () => const BottomNavBaseScreen());
                                  } else {
                                    Get.snackbar(
                                        'Failed', 'Login failed, try again');
                                  }
                                });
                              }
                            },
                            child: const Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 16,
                    ),
                    Center(
                      /*  child: TextButton(onPressed: (){}, child: const Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey),
                      ),),*/
                      child: InkWell(
                        onTap: () {
                          Get.to(() => EmailVerificationScreen());
                          /*  Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EmailVerificationScreen())); */
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have account? ",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, letterSpacing: 0.5),
                        ),
                        TextButton(
                            onPressed: () {
                              Get.to(() => SignUpScreen());
                             /*  Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpScreen(),
                                ),
                              ); */
                            },
                            child: const Text("Sign up")),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
