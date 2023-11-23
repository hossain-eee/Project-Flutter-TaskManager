import 'package:flutter/material.dart';
import 'package:module_11_class_3/data/models/auth_utility.dart';
import 'package:module_11_class_3/ui/screens/auth/login_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:module_11_class_3/ui/screens/update_profie.dart';

class UserProfileAppBar extends StatefulWidget {
  const UserProfileAppBar({
    super.key,
    //  this.isUpdateProfileScreen, // when isUpdateProfileScreen is nullable
    required this.isUpdateProfileScreen,
  });
  //take a flag to ensure we are in update_profile.dart screen, so that Navigator will not work. bcoz we navigato to update_profile.dart screen from other page, when inside that page then navigate is not need.
  // final bool? isUpdateProfileScreen; //
  final bool isUpdateProfileScreen;

  @override
  State<UserProfileAppBar> createState() => _UserProfileAppBarState();
}

class _UserProfileAppBarState extends State<UserProfileAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: GestureDetector(
        //to make the banner clickable, so that by click bannaer user can update profile
        onTap: () {
          // if ((widget.isUpdateProfileScreen ?? false) == false) {}//we set conditon like this, but parameter make nullable by ?
          if (!widget.isUpdateProfileScreen) {
            //when user is not in update profile page then Navigator will work
            Get.to(() => const UpdateProfile());
            /*  Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UpdateProfile(),
              ),
            ); */
          }
        },

        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                CachedNetworkImage(
                  placeholder: (_, __) =>
                      const Icon(Icons.account_circle_rounded),

                  imageUrl: AuthUtility.userInfo.data?.photo ??
                      '', //image taken from sharedPrefe
                  errorWidget: (_, __, ___) =>
                      // Icon(Icons.account_circle_outlined),
                      const CircleAvatar(
                    backgroundImage: AssetImage("assets/images/profile.png"),
                    radius: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  //AuthUtility.userInfo.data?.firstName it can be null, so set if null then defalut vlaue. first name is empty then show "user name" and last name is empty show "" empty string
                  "${AuthUtility.userInfo.data?.firstName ?? "user name"} ${AuthUtility.userInfo.data?.lastName ?? " "}",
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
                Text(
                  AuthUtility.userInfo.data?.email ?? "Email address",
                  style: const TextStyle(fontSize: 11, color: Colors.white),
                ),
              ],
            )
          ],
        ),
      ),
      actions: [
        //logout button

        IconButton(
            onPressed: () {
              AuthUtility.clearUserInfo(); //clear shared preference all data
              if (mounted) {
                Get.offAll(() => const LoginScreen());
               /*  Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) {
                  return const LoginScreen(); // after logout go to loginScreen()
                }), (route) => false); */
              }
            },
            icon: const Icon(Icons.logout)),
      ],
    );
  }
}
