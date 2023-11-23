import 'package:flutter/material.dart';
import 'package:module_11_class_3/data/models/auth_utility.dart';
import 'package:module_11_class_3/data/models/login_model.dart';
import 'package:module_11_class_3/ui/widgets/user_profile_banner.dart';
import '../state_managers/update_profile_controller.dart';
import '../widgets/screen_background.dart';
import 'package:get/get.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  /*############## Get user login information  ############################*/
  /*  UserData userData = AuthUtility.userInfo
      .data!; // get user login information from sharedPreference object  /cached, so it will not be null */
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //controller
  final UpdateProfileController _updateProfileController =
      Get.find<UpdateProfileController>();
  

      final UserData _userData = AuthUtility.userInfo
      .data!; // get user login information from sharedPreference object  /cached, so it will not be null,  because user is in update profile, and witout sign in it's not possible(we make it)
  //we want user logn information when user enter this page, so use initState()
  @override
  void initState() {
    super.initState();
    //get data form SharedPreference objecct
    _emailTEController.text = _userData.email ?? '';
    _firstNameTEController.text =_userData.firstName ?? '';
    _lastNameTEController.text =_userData.lastName ?? '';
    _mobileTEController.text =_userData.mobile ?? '';
    //we don't want to show/expose password, if show, it will compromise user privacy
  }

  void selectedImage() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.greenAccent,
            contentPadding: EdgeInsets.zero,
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text(
              "Select one",
              textAlign: TextAlign.center,
            ),
            content: GetBuilder<UpdateProfileController>(
                builder: (updateProfileController) {
              return Row(
                children: [
                  Expanded(
                    child: ListTile(
                      onTap: () {
                        updateProfileController.picGalleryImage();
                        // Navigator.pop(context);
                        Get.back();
                      },
                      title: const Icon(
                        Icons.browse_gallery_sharp,
                        size: 35,
                      ),
                      subtitle: const Text(
                        "Gallery",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    child: ListTile(
                      onTap: () {
                        updateProfileController.pickCameraImage();
                        // Navigator.pop(context);
                        Get.back();
                      },
                      title: const Icon(
                        Icons.camera_alt,
                        size: 35,
                      ),
                      subtitle:
                          const Text("Camera", style: TextStyle(fontSize: 20)),
                    ),
                  ),
                ],
              );
            }),
            actions: [
              IconButton(
                  onPressed: () {
                    // Navigator.pop(context);
                    Get.back();
                  },
                  icon: const Icon(Icons.close))
            ],
          );
        });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Column(
          children: [
            const UserProfileAppBar(
              isUpdateProfileScreen: true,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 60,
                        ),
                        Text(
                          "Update Profile",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        //photo
                        Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  selectedImage();
                                },
                                child: Container(
                                  width: 90,
                                  padding: const EdgeInsets.all(16),
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 102, 102, 102),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      bottomLeft: Radius.circular(5),
                                    ),
                                  ),
                                  child: const Text(
                                    'Photos',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              GetBuilder<UpdateProfileController>(
                                  builder: (imagePickerController) {
                                return Visibility(
                                  visible:
                                      imagePickerController.imageFile != null,
                                  child: SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.6,
                                    child: Text(
                                      imagePickerController.imageFile?.name ??
                                          '',
                                      maxLines: 2,
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        //email
                        TextFormField(
                          controller: _emailTEController,
                          readOnly: true, // user can't update email address
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          validator: (String? value) {
                            if (value?.isEmpty ?? true) {
                              return 'Enter your email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        //first name
                        TextFormField(
                          controller: _firstNameTEController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            hintText: 'First Name',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          validator: (String? value) {
                            if (value?.isEmpty ?? true) {
                              return 'Enter your first name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        //last name
                        TextFormField(
                          controller: _lastNameTEController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            hintText: 'Last Name',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          validator: (String? value) {
                            if (value?.isEmpty ?? true) {
                              return 'Enter your last name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        //mobile
                        TextFormField(
                          controller: _mobileTEController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            hintText: 'Mobile',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          validator: (String? value) {
                            if ((value?.isEmpty ?? true) ||
                                value!.length < 11) {
                              //if value is null then first step it will return ture, so if it goes to length then vlaue must contain something
                              return 'Enter your mobile number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          controller: _passwordTEController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          validator: (String? value) {
                            //logic- if user don't want to set new password, then empty field will pass but we will not count this empty field, store prevous password in post method
                            if (value?.isEmpty ?? true) {
                              return null;
                            }
                            //if user set password then password must be 5 character
                            if (value!.length <= 5) {
                              return 'Enter a password more than 5 letters';
                            }
                            return null; //when password has morethan 5 character then return null, that mean good to go
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        //button for submit
                        GetBuilder<UpdateProfileController>(
                            builder: (updateProfileController) {
                          return SizedBox(
                            width: double.infinity,
                            child: updateProfileController.isProfileInProgress
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : ElevatedButton(
                                    onPressed: () {
                                      if (!_formKey.currentState!.validate()) {
                                        return;
                                      }
                                      updateProfileController
                                          .updateProfile(
                                              _firstNameTEController.text
                                                  .trim(),
                                              _lastNameTEController.text.trim(),
                                              _mobileTEController.text.trim(),
                                              _passwordTEController.text)
                                          .then((value) {
                                        if (value) {
                                          _passwordTEController.clear();
                                        }
                                      });
                                    },
                                    child: const Icon(Icons.arrow_forward_ios),
                                  ),
                          );
                        }),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
