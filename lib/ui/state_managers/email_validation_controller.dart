import 'package:get/get.dart';
import 'package:module_11_class_3/ui/screens/auth/opt_verification_screen.dart';

import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class EmailValidationController extends GetxController {
  bool _isEmailVerficatinInProgress = false;

  //getter
  bool get isEmailVerficatinInProgress => _isEmailVerficatinInProgress;
  //Api calling method
  Future<void> sendOTPToEmail(String email) async {
    _isEmailVerficatinInProgress = true;
    update();
    NetworkResponse response =
        await NetworkCaller().getRequest(Urls.sendOtpToEmail(email));

    _isEmailVerficatinInProgress = false;
    update();

    if (response.isSuccess) {
      Get.snackbar('OTP', 'otp has been send to your email address');
      Get.to(() => OtpVerificationScreen(email: email));
    } else {
      Get.snackbar("Failed", 'Email verification has been failed!');
   
    }
  }
}
