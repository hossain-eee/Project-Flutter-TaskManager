import 'package:get/get.dart';
import 'package:module_11_class_3/data/models/auth_utility.dart';
import 'package:module_11_class_3/data/models/login_model.dart';
import 'package:module_11_class_3/data/models/network_response.dart';
import 'package:module_11_class_3/data/services/network_caller.dart';
import 'package:module_11_class_3/data/utils/urls.dart';

/* Make controller as small as possible, login controller is only for login purpose, sign up would not here. so we have to make many controller */
class LoginController extends GetxController {
  bool _isLoginInProgress = false;
  bool get isLoginInProgress => _isLoginInProgress; // getter method to access this private variable from outside of this file, use getter method so that none can modify it outside of this class/file

  Future<bool> login(String email, String password) async {
    _isLoginInProgress = true;
    update(); // instead of setState((){})
    Map<String, dynamic> requestBody = {
      "email": email,
      "password": password,
    };
    //model class data type, becouse we stroe data in our model class form server
    NetworkResponse response = await NetworkCaller().postRequest(
        Urls.login, requestBody,
        isLogin:
            true); //isLogin: true flag, is only apply in logged in page because its optional
    _isLoginInProgress = false;
    update(); // instead of setState((){})
    if (response.isSuccess) {
      //code is here mean login is successful, so store login information to shared preference to auto login in next time by model class
/*       LoginModel model = LoginModel.fromJson(response
          .body!); //login success mean response.body must have data, force it by (!)

      //now feed this data to shared preference
      await AuthUtility.saveUserInfo(model); //save data to shared preference */

      await AuthUtility.saveUserInfo(LoginModel.fromJson(response.body!));

      return true;
    } else {
      return false;
    }
  }
}
