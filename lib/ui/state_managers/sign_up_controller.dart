import 'dart:developer';

import 'package:get/get.dart';

import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class SignUpController extends GetxController {
  //flag for singn up progress to display circular indicator
  bool _signUpInProgress = false;
//getter method
  bool get signUpInProgress => _signUpInProgress;
  //method for receive data from user and post to server
  Future<bool>? userSignUp(
    String email,
    String firstName,
    String lastName,
    String mobile,
    String password,
  ) async {
    //starting network activity
    _signUpInProgress = true;
    update();
    //body of postRequest, feed data to post in server
    Map<String, dynamic> requestBody = {
      //from postman post body
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password, // password can be space, so don't trim it
      "photo": ""
    };
    //variable is our model data type= calling postRequest() method via object
    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.registration, requestBody);

//end network activity
    _signUpInProgress = false;
    update();

    //make empty contoller
    print("response.isSuccess : ${response.isSuccess}");
    log(response.isSuccess.toString());

    if (response.isSuccess) {
      
      // Get.snackbar("Successful", 'Registration Success!');
      return true;
    } else {
      Get.snackbar("Fail", "Registration Failed!");
      return false;
    }
  }
}
