import 'package:get/get.dart';

import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../screens/auth/reset_password_screen.dart';

class OtpVerificationController extends GetxController {
  bool _isOtpVerificationInProgress = false;

  //getter
  bool get isOtpVerificationInProgress => _isOtpVerificationInProgress;
  //api calling method
  Future<void> verifyOTP(String email, String otp) async {
    _isOtpVerificationInProgress = true;
    update();
    NetworkResponse response =
        await NetworkCaller().getRequest(Urls.otpVerify(email, otp));
    _isOtpVerificationInProgress = false;
    update();
    //otp verificaton, take status for check input code is correct or not.
    if (response.isSuccess && response.body?['status'] == 'success') {
      Get.to(() => ResetPasswordScreen(
            email: email,
            otp: otp,
          ));
      /* if (mounted) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ResetPasswordScreen(
              email: widget.email, otp: _otpTEController.text);
        }));
      } */
    } else {
      Get.snackbar('Failed', 'Otp verification has been failed!');
    /*   if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Otp verification has been failed!')));
      } */
    }
  }
}
