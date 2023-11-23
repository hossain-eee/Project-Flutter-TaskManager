import 'dart:convert';

import 'package:module_11_class_3/data/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthUtility {
  AuthUtility._();
  //create instance, get data when user is logged in  and save userInfo to this instance variable
  static LoginModel userInfo = LoginModel();

  //Shared preferences
//set method for save user information, which parameter data type is model class
  static Future<void> saveUserInfo(LoginModel model) async {
    SharedPreferences _sharedPrefs = await SharedPreferences.getInstance();
    await _sharedPrefs.setString(
        'user-data',
        jsonEncode(model.toJson() //stroe by encode data into json
));
    userInfo =
        model; // for new login, because new login don't check checkUserLoggedIn() method to check is user logged in or not, thats why userInfo variable don't have data, so put direct fresh data (model) to userInfo when user logged In. to show user name, email etc. otherwise user details will empty in user_profile_banner.dart file
  }

    //set method for save update userData
    static Future<void> updateUserInfo(UserData data) async {
    SharedPreferences _sharedPrefs = await SharedPreferences.getInstance();
    /* sharedPrefs object userInfo store data according to blueprint of LoginModel, 
    our UserData is subClass of LoginModel, so we can save/replace new data to old data */
    userInfo.data = data; //userInfo.data contain the all login information, replace previous data by new user provide data(parameter) 
    await _sharedPrefs.setString(
        'user-data',
        // jsonEncode(data.toJson() )//stroe by encode data into json, but data is object of UserData which don't have token, so it will throw token error.
            jsonEncode(userInfo.toJson()), // userInfo is object of LoginModel, which have token varibale
            );
   
  }

//get the user information which we have saved
  static Future<LoginModel> getUserInfo() async {
    SharedPreferences _sharedPrefs = await SharedPreferences.getInstance();
    String value = _sharedPrefs.getString(
        'user-data')!; //force that its not null, because we check it by bool value that data present
    return LoginModel.fromJson(
      jsonDecode(value),
    ); //return json encoded data into LoginModel type and decode it
  }

//clear data from shared preference, its use for log out to clear user all data

  static Future<void> clearUserInfo() async {
    SharedPreferences _sharedPrefs = await SharedPreferences.getInstance();
    await _sharedPrefs.clear();
  }

//check user login or not, if key has value that mean user login and save data that's why key has value so its a valid user and return true
  static Future<bool> checkUserLoggedIn() async {
    SharedPreferences _sharedPrefs = await SharedPreferences.getInstance();
    bool isLogin = _sharedPrefs.containsKey('user-data');
    if (isLogin) {
      userInfo =
          await getUserInfo(); //instance variable get data when user is loggin so userInfo has data from api joson, use this data to get user name, email etc. this is only for previously loggedIn user when auto login because this method is called only in SplashScreen to check user loggedIn or not.
    }
    return isLogin;
  }
}
