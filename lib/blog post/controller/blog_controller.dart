import 'dart:io';

import 'package:blogy/blog%20post/api/firebase_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

enum CategoryBlog { sports, movies }

class BlogController extends GetxController {
  var setupImageLink = ''.obs;
  var firebaseSetupImageLink = ''.obs;
  Rx<CategoryBlog> categoryBlog = CategoryBlog.sports.obs;
  Rx<TextEditingController> titleController = TextEditingController().obs;
  Rx<TextEditingController> descriptionController = TextEditingController().obs;

  setCategoryBlog(value) {
    categoryBlog.value = value;
  }

  imgFromGallery() async {
    try {
      final ImagePicker? picker = ImagePicker();
      XFile? image = await picker!.pickImage(source: ImageSource.gallery);
      setupImageLink.value = image!.path;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  uploadPost() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      String destination = user!.displayName!;
      final storage = FirebaseStorage.instance;
      UploadTask? task = FirebaseApi.uploadFile(
          destination, File(setupImageLink.value), storage);
      if (task == null) return null;
      Get.defaultDialog(
        barrierDismissible: false,
        onWillPop: () async => false,
        title: 'Uploading Post',
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Center(
              child: CircularProgressIndicator(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text('Please wait'),
            )
          ],
        ),
      );
      final snapshot = await task.whenComplete(() {});
      firebaseSetupImageLink.value = await snapshot.ref.getDownloadURL();

      await addToUserBlog(user);
      await addToBloggy(user);
      Navigator.of(Get.context!).popUntil((route) => route.isFirst);
      Get.snackbar("Blog", 'Posted succesfully');
    } on Exception catch (e) {
      Get.snackbar('Add', 'all Data');
    }
  }

  Future<void> addToUserBlog(User user) async {
    CollectionReference _user = FirebaseFirestore.instance.collection('users');
    QuerySnapshot _collection = await FirebaseFirestore.instance
        .collection('user')
        .doc(user.displayName)
        .collection('post')
        .get();
    int _length = _collection.size;
    _user.doc(user.displayName).collection('post').add({
      'id': _length + 1,
      'title': titleController.value.text,
      'desc': descriptionController.value.text,
      'author': user.displayName,
      'category':
          categoryBlog.value == CategoryBlog.movies ? 'movies' : 'sports',
      'img': firebaseSetupImageLink.value,
    });
  }

  Future<void> addToBloggy(User user) async {
    CollectionReference _blog = FirebaseFirestore.instance.collection('bloggy');
    QuerySnapshot collection =
        await FirebaseFirestore.instance.collection('bloggy').get();
    int length = collection.size;
    _blog.add({
      'id': length + 1,
      'title': titleController.value.text,
      'desc': descriptionController.value.text,
      'author': user.displayName,
      'category':
          categoryBlog.value == CategoryBlog.movies ? 'movies' : 'sports',
      'img': firebaseSetupImageLink.value,
    });
  }
}
