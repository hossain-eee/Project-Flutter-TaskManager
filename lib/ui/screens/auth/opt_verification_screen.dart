import 'package:flutter/material.dart';
import 'package:module_11_class_3/ui/widgets/screen_background.dart';
import '../../state_managers/otp_verification_controller.dart';
import 'login_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:get/get.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;
  const OtpVerificationScreen({super.key, required this.email});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpTEController =
      TextEditingController(); // use this inside PinCodeTextField ( pin_code_fields package) to receive otp you enter
  // bool _isOtpVerificationInProgress = false;
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
                      "PIN Verification",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "A 6 digit verification pin will send to your email address",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.grey),
                    ),
                    //default bodyMedium value will apply where we just modify color
                    const SizedBox(
                      height: 24,
                    ),

                    //Otp
                    PinCodeTextField(
                      controller: _otpTEController,
                      appContext: context,
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                        activeColor: Colors.white,
                        inactiveFillColor: Colors.white,
                        inactiveColor: Colors.red,
                        selectedFillColor: Colors.white,
                        selectedColor: Colors.green,
                      ),
                      //add validator for 6 digit otp form
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter OTP';
                        }
                        if (value!.length < 6) {
                          return 'Enter 6 digit otp';
                        }
                        return null;
                      },

                      cursorColor: Colors.green,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      keyboardType: TextInputType.number,
                      onCompleted: (v) {},
                      onChanged: (value) {},
                      beforeTextPaste: (text) {
                        debugPrint("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    //button for submit
                    GetBuilder<OtpVerificationController>(
                        builder: (otpVerificationController) {
                      return SizedBox(
                        width: double.infinity,
                        child: Visibility(
                          visible: otpVerificationController
                                  .isOtpVerificationInProgress ==
                              false,
                          replacement: const Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }
                              otpVerificationController.verifyOTP(
                                  widget.email, _otpTEController.text.trim());
                            },
                            child: const Text("Verify"),
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
                          "Have account? ",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, letterSpacing: 0.5),
                        ),
                        TextButton(
                            onPressed: () {
                              //user have an account so back to login page
                              Get.offAll(() => const LoginScreen());
                             /*  Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()),
                                  (route) => false); */
                            },
                            child: const Text("Sign in")),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
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
