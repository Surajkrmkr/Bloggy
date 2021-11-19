import 'dart:io';
import 'dart:math';
import 'package:blogy/blog%20post/controller/blog_controller.dart';
import 'package:blogy/blog%20post/model/blog_model.dart';
import 'package:blogy/themes/colors.dart';
import 'package:blogy/themes/fonts.dart';
import 'package:blogy/users/controller/auth_user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostBlogPage extends StatelessWidget {
  PostBlogPage({Key? key}) : super(key: key);
  final BlogController blogController = Get.put(BlogController());
  final AuthUser authUser = Get.find();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Obx(() {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add Blog",
                  style: MyFont.getTextStyle(
                      25, MyColors.accentColor, FontWeight.bold),
                ),
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Container(
                      height: 200,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: MyColors.backgroundHeader[Random()
                              .nextInt(MyColors.backgroundHeader.length)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Stack(
                        children: [
                          // ignore: unrelated_type_equality_checks
                          blogController.setupImageLink != ''
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.file(
                                      File(blogController.setupImageLink.value),
                                      width: Get.width,
                                      fit: BoxFit.cover),
                                )
                              : Container(),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: IconButton(
                                onPressed: () {
                                  blogController.imgFromGallery();
                                },
                                icon: Icon(
                                  // ignore: unrelated_type_equality_checks
                                  blogController.setupImageLink != ''
                                      ? Icons.edit
                                      : Icons.add_a_photo,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Title',
                    isDense: true,
                    labelStyle:
                        MyFont.getTextStyle(20, Colors.grey, FontWeight.normal),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          BorderSide(color: MyColors.accentColor, width: 3.0),
                    ),
                  ),
                  controller: blogController.titleController.value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Oops Missing Data!';
                    }
                  },
                  maxLines: 3,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Description',
                      isDense: true,
                      labelStyle: MyFont.getTextStyle(
                          20, Colors.grey, FontWeight.normal),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            BorderSide(color: MyColors.accentColor, width: 3.0),
                      ),
                    ),
                    controller: blogController.descriptionController.value,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Oops Missing Data!';
                      }
                    },
                    maxLines: 8,
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Category',
                    style:
                        MyFont.getTextStyle(18, Colors.black, FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(children: [
                    Flexible(
                      child: ListTile(
                        onTap: () {
                          blogController.setCategoryBlog(CategoryBlog.sports);
                        },
                        title: Text(
                          'Sports',
                          style: MyFont.getTextStyle(
                              18, Colors.black, FontWeight.normal),
                        ),
                        leading: Radio(
                          value: CategoryBlog.sports,
                          groupValue: blogController.categoryBlog.value,
                          onChanged: (value) {
                            blogController.setCategoryBlog(value);
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      child: ListTile(
                        onTap: () {
                          blogController.setCategoryBlog(CategoryBlog.movies);
                        },
                        title: Text(
                          'Movies',
                          style: MyFont.getTextStyle(
                              18, Colors.black, FontWeight.normal),
                        ),
                        leading: Radio(
                          value: CategoryBlog.movies,
                          groupValue: blogController.categoryBlog.value,
                          onChanged: (value) {
                            blogController.setCategoryBlog(value);
                          },
                        ),
                      ),
                    ),
                  ]),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          try {
                            blogController.uploadPost();
                            authUser.addUsertoBloggy();
                          } catch (e) {
                            Get.snackbar(
                              'Error',
                              'Please add data',
                            );
                          }
                        } else {
                          Get.snackbar('Error', 'Missing Data');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          primary: MyColors.accentColor,
                          onPrimary: Colors.white,
                          minimumSize: const Size(130, 40)),
                      child: Text(
                        'Post',
                        style: MyFont.getTextStyle(
                            18, Colors.white, FontWeight.bold),
                      )),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
