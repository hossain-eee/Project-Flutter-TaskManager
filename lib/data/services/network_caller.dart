import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart ';
import 'package:module_11_class_3/data/models/auth_utility.dart';
import 'package:module_11_class_3/data/models/network_response.dart';
import 'package:module_11_class_3/ui/screens/auth/login_screen.dart';
import 'package:http/http.dart' as http;
class NetworkCaller {
  /* #########################get method to receive data form server ###################### */
  //we want to store data to our NetworkResponse model class
  Future<NetworkResponse> getRequest(String url) async {
    log(url); // check url
    try {
      http.Response response = await get(
        Uri.parse(url),
        headers: {
          'token': AuthUtility.userInfo.token
              .toString(), // sometimes get request need token
        },
      );
      log(response.statusCode
          .toString()); //check weather its success or not in terminal
      log(response.body); //check body content in terminal
      if (response.statusCode == 200) {
        return NetworkResponse(
          true,
          response.statusCode,
          jsonDecode(response.body),
        ); //code is here means,if conditon() is true that mean operation succcessfull that is why we set true
      } else if (response.statusCode == 401) {
        //401 is token error
        gotoLogin();
      } else {
        //todo- to handle other response code-400,401,500
        return NetworkResponse(false, response.statusCode, null);
        //code is here mean, if condition is not true, so make isSuccess=false, and get the respose code, now its error so no response body data will come that is why make it null
      }
    } catch (e) {
      log(e
          .toString()); //code is here mean try can't execcute , print development background error, which for developer
    }
    return NetworkResponse(false, -1,
        null); // code is here mean catch can't execcute total fail to operation, so we server don't give us status code that is why take -1 which is not matchc with server code or any other code, and oviously body don't have any value
  }

  /*  ####################### Post method to post data into server###################### */
  //we want to store data to our NetworkResponse model class
  Future<NetworkResponse> postRequest(
     
      // body data is encode/decode , and status is by defalut text or String so its no need to encode/decode bcoz response is the part of header
      String url,
      Map<String, dynamic> body,
      {bool isLogin =
          false} //optional parameter to ensure code in login page, that is why optional parameter we will use it only login screen isLogin=true, other screen will take default false
      ) async {
         log(url);//check url
    try {
      http.Response response = await post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'token': AuthUtility.userInfo.token
              .toString(), //add token to add data to server by api
        }, //map type
        body: jsonEncode(body),
      ); //String to json that is why jsonEncode

      log(response.statusCode.toString());
      log(response.body);

      if (response.statusCode == 200) {
        return NetworkResponse(
          true, //code is here means,if conditon() is true that mean operation succcessfull that is why we set true
          response.statusCode,
          jsonDecode(response.body), // json to String
        );
      } else if (response.statusCode == 401) {
        //401 is token error
        if (isLogin == false) {
          //token validation is 36 hours for each time login
          //user was loggedIn but token time expired that is why can't post anything, so force to sign out and navigate to login page to loggedIn again
          gotoLogin(); //
        }
      } else {
        //todo- to handle other response code-400,401,500
        return NetworkResponse(false, response.statusCode, null);
        //code is here mean, if condition is not true, so make isSuccess=false, and get the respose code, now its error so no response body data will come that is why make it null
      }
    } catch (e) {
      log(e
          .toString()); //code is here mean try can't execcute , print development background error, which for developer
    }
    return NetworkResponse(false, -1,
        null); // code is here mean catch can't execcute total fail to operation, so we server don't give us status code that is why take -1 which is not matchc with server code or any other code, and oviously body don't have any value
  }

/* ################## Login method for token error handle ######################## */
  //if token got any error, then force user to logout and navigate to login screen
  Future<void> gotoLogin() async {
    await AuthUtility
        .clearUserInfo(); //clear user information that mean forcefully sign out
        Get.offAll( () => const LoginScreen() ); // navigate to login screen
       /*  Navigator.pushAndRemoveUntil(TaskManagerApp.globalKey.currentContext!,
        MaterialPageRoute(builder: (context) {
      return const LoginScreen(); // navigate to login screen
    }), (route) => false); */
  }
}
