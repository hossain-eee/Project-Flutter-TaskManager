import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:module_11_class_3/data/models/auth_utility.dart';
import 'package:module_11_class_3/data/models/login_model.dart';

import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class UpdateProfileController extends GetxController {
  final ImagePicker picker = ImagePicker();
  XFile? imageFile;
  bool _isProfileInProgress = false;

  //getter

  bool get isProfileInProgress => _isProfileInProgress;

  //image picker
  void pickCameraImage() {
    picker.pickImage(source: ImageSource.camera).then((xFile) {
      if (xFile != null) {
        imageFile = xFile;
        update();
      }
    });
  }

  void picGalleryImage() {
    picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        imageFile = xFile;
        update();
      }
    });
  }

  //user profile update method
  Future<bool> updateProfile(
      String firstName, String lastName, String mobile, String password) async {
    _isProfileInProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "photo": ""
    };
    //some users maybe not interested to change password, that's why set password by condition
    if (password.isNotEmpty && password.length >= 5) {
      requestBody['password'] = password;
    }

    //api post method
    NetworkResponse response =
        await NetworkCaller().postRequest(Urls.updateProfile, requestBody);

    _isProfileInProgress = false;
    update();
    if (response.isSuccess) {
      UserData userData = AuthUtility.userInfo.data!;
      //net data already post in server, now these new data set(replace) to our class object which hold sharedPreference login data
      userData.firstName = firstName;
      userData.lastName = lastName;
      userData.mobile = mobile;
      //now feed this object which contain new login information to sharedPreference
      AuthUtility.updateUserInfo(userData);
      // _passwordTEController.clear(); // for security,
      /*    if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated!'),
          ),
        );
      } */
      Get.snackbar("Success", 'Profile updated!');
      return true;
    } else {
      Get.snackbar('Failed', 'Profile update failed! Try again.');
      return false;
      /*    if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile update failed! Try again.'),
          ),
        );
      } */
    }
  }
}
