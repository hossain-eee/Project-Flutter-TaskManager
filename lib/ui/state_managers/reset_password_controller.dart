import 'package:get/get.dart';

import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../screens/auth/login_screen.dart';

class ResetPasswordController extends GetxController {
  bool _isSetPasswordInProgress = false;
//getter
  bool get isSetPasswordInProgress => _isSetPasswordInProgress;

  //api calling method
  Future<void> resetPassword(
    String email,
    String OTP,
    String password,
  ) async {
    _isSetPasswordInProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "email": email,
      "OTP": OTP,
      "password": password,
    };
    NetworkResponse response =
        await NetworkCaller().postRequest(Urls.resetPassword, requestBody);
    _isSetPasswordInProgress = false;
    update();
    if (response.isSuccess) {
      Get.snackbar("Success", 'Password reset successful!');
      Get.offAll(()=>const LoginScreen());
   
    } else {
      Get.snackbar("Failed", 'Reset password has been failed!');

    }
  }
}
