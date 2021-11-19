import 'dart:math';

import 'package:blogy/authentication/controller/google_sign_in.dart';
import 'package:blogy/profile/profile_blog.dart';
import 'package:blogy/users/controller/auth_user.dart';
import 'package:blogy/themes/colors.dart';
import 'package:blogy/themes/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key, required this.isUserItself, this.otherUser})
      : super(key: key);
  final bool isUserItself;
  final OtherUser? otherUser;
  final AuthUser authUser = Get.find<AuthUser>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            child: Container(
              height: Get.height * 0.5,
              width: Get.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: MyColors.backgroundHeader[
                      Random().nextInt(MyColors.backgroundHeader.length)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: Get.height * 0.7,
              width: Get.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Text(
                        !isUserItself
                            ? authUser.user.value!.displayName!
                            : otherUser!.name!,
                        style: MyFont.getTextStyle(
                            25, MyColors.accentColor, FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Divider(
                        color: MyColors.accentColor.withOpacity(0.3),
                        thickness: 3,
                        indent: 120,
                        endIndent: 120,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        'Blogs',
                        style: MyFont.getTextStyle(
                            20, MyColors.accentColor, FontWeight.normal),
                      ),
                    ),
                    !isUserItself ? ProfileBlogs(name: authUser.user.value!.displayName!,):ProfileBlogs(name: otherUser!.name!),
                    !isUserItself
                        ? ElevatedButton(
                            onPressed: () async {
                              GoogleSignInProvider provider =
                                  Provider.of<GoogleSignInProvider>(context,
                                      listen: false);
                              provider.logout();
                              Get.delete<AuthUser>();
                              await DefaultCacheManager().emptyCache();
                              Get.back();
                            },
                            style: ElevatedButton.styleFrom(
                                primary: MyColors.accentColor,
                                onPrimary: Colors.white,
                                minimumSize: const Size(130, 40)),
                            child: const Text('Sign out'))
                        : const SizedBox()
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              top: Get.height * 0.20,
              child: !isUserItself
                  ? CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.white,
                      backgroundImage:
                          NetworkImage(authUser.user.value!.photoURL!),
                    )
                  : CircleAvatar(
                      radius: 70,
                      backgroundColor: MyColors.accentColor,
                      child: const Icon(
                        Icons.person,
                        size: 60,
                      ),
                    )),
        ],
      ),
    );
  }
}
