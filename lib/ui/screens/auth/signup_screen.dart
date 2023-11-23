import 'package:flutter/material.dart';
import 'package:module_11_class_3/ui/widgets/screen_background.dart';
import 'package:get/get.dart';

import '../../state_managers/sign_up_controller.dart';

// import 'package:regexpattern/regexpattern.dart';
class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

//flag for singn up progress to display circular indicator
bool _signUpInProgress = false;

class _SignUpScreenState extends State<SignUpScreen> {
  //controller for TextFomField()
  final TextEditingController _emailTEController = TextEditingController();

  final TextEditingController _firstNameTEController = TextEditingController();

  final TextEditingController _lastNameTEController = TextEditingController();

  final TextEditingController _mobileTEController = TextEditingController();

  final TextEditingController _passwordTEController = TextEditingController();

//global key for Form()
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                      "Join With Us",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    //email
                    TextFormField(
                      controller: _emailTEController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      //Regex for email validator
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
                    //first name
                    TextFormField(
                      controller: _firstNameTEController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: 'First Name',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter your first name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    //last name
                    TextFormField(
                      controller: _lastNameTEController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: 'Last Name',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter your last name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    //mobile
                    TextFormField(
                      controller: _mobileTEController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: 'Mobile',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      validator: (String? value) {
                        if ((value?.isEmpty ?? true) || value!.length < 11) {
                          //if value is null then first step it will return ture, so if it goes to length then vlaue must contain something
                          return 'Enter your mobile number';
                        }
                        return null;
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
                      validator: (value) {
                        if ((value?.isEmpty ?? true) || value!.length <= 5) {
                          return 'Enter a password more than 6 letters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    //button for submit
                    GetBuilder<SignUpController>(builder: (signUpController) {
                      return SizedBox(
                        width: double.infinity,
                        child: Visibility(
                          visible: _signUpInProgress == false,
                          replacement: const Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }

                              signUpController
                                  .userSignUp(
                                      _emailTEController.text.trim(),
                                      _firstNameTEController.text.trim(),
                                      _lastNameTEController.text.trim(),
                                      _mobileTEController.text.trim(),
                                      _passwordTEController.text.trim())
                                  ?.then((value) {
                                if (value) {
                                  _emailTEController.clear();
                                  _firstNameTEController.clear();
                                  _lastNameTEController.clear();
                                  _mobileTEController.clear();
                                  _passwordTEController.clear();
                                  Get.snackbar(
                                      "Successful", 'Registration Success!');
                                }
                              });
                            },
                            child: const Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 16,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "have an account? ",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, letterSpacing: 0.5),
                        ),
                        TextButton(
                            onPressed: () {
                              // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const LoginScreen()), (route) => false);
                              //back to login page
                              // Navigator.pop(context);
                              Get.back();
                            },
                            child: const Text("Sign in")),
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
