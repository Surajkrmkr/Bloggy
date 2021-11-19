import 'package:blogy/profile/profile_page.dart';
import 'package:blogy/users/controller/auth_user.dart';
import 'package:blogy/themes/colors.dart';
import 'package:blogy/themes/fonts.dart';
import 'package:blogy/widgets/home_page_blogs.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final AuthUser authUser = Get.put(AuthUser());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
          ),
          child: Text(
            "Bloggy",
            style:
                MyFont.getTextStyle(30, MyColors.accentColor, FontWeight.bold),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => ProfilePage(isUserItself: false,));
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 20.0),
              child: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(authUser.user.value!.photoURL!),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: HomePageBlog(
          blog: FirebaseFirestore.instance
              .collection('bloggy')
              .orderBy('id', descending: true)
              .snapshots(),
        ),
      ),
    );
  }
}
