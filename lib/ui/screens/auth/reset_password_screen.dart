import 'package:flutter/material.dart';
import 'package:module_11_class_3/ui/widgets/screen_background.dart';
import '../../state_managers/reset_password_controller.dart';
import 'login_screen.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email, otp;
  const ResetPasswordScreen(
      {super.key, required this.email, required this.otp});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController =
      TextEditingController();

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
                      "Set Password",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Minimum length password 8 character with latter and number combination",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.grey),
                    ),
                    //default bodyMedium value will apply where we just modify color

                    const SizedBox(
                      height: 24,
                    ),
                    //password
                    TextFormField(
                      controller: _passwordTEController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.grey)),
                      validator: (value) {
                        if ((value?.isEmpty ?? true) || value!.length <= 5) {
                          return 'Enter a password more than 6 letters';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(
                      height: 12,
                    ),
                    //confirm password
                    TextFormField(
                      controller: _confirmPasswordTEController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          hintText: 'Confirm Password',
                          hintStyle: TextStyle(color: Colors.grey)),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter your confirm pasword';
                        } else if (value! != _passwordTEController.text) {
                          return 'Confirm password does n\'t match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    //button for submit
                    GetBuilder<ResetPasswordController>(
                        builder: (resetPasswordController) {
                      return SizedBox(
                        width: double.infinity,
                        child: Visibility(
                          visible:
                              resetPasswordController.isSetPasswordInProgress ==
                                  false,
                          replacement: const Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }
                              resetPasswordController.resetPassword(
                                  widget.email,
                                  widget.otp,
                                  _passwordTEController.text);
                            },
                            child: const Text("Confirm"),
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
                          "Have an account?",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, letterSpacing: 0.5),
                        ),
                        TextButton(
                            onPressed: () {
                              //user have an account so back to login page
                              Get.offAll(() => const LoginScreen());
                            },
                            child: const Text("Sign in")),
                      ],
                    ),
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
