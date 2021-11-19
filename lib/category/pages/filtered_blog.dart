import 'package:blogy/category/controller/filter_controller.dart';
import 'package:blogy/widgets/home_page_blogs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilteredPage extends StatelessWidget {
  FilteredPage({Key? key}) : super(key: key);
  final FilterController filterController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (filterController.isMovies.value && filterController.isSports.value) {
        return HomePageBlog(
          blog: FirebaseFirestore.instance
              .collection('bloggy')
              .orderBy('id', descending: true)
              .snapshots(),
        );
      } else if (filterController.isMovies.value) {
        return HomePageBlog(
          blog: FirebaseFirestore.instance
              .collection('bloggy')
              .where('category', isEqualTo: 'movies')
              .snapshots(),
        );
      } else if (filterController.isSports.value) {
        return HomePageBlog(
          blog: FirebaseFirestore.instance
              .collection('bloggy')
              .where('category', isEqualTo: 'sports')
              .snapshots(),
        );
      } else {
        return HomePageBlog(
          blog: FirebaseFirestore.instance
              .collection('bloggy')
              .orderBy('id', descending: true)
              .snapshots(),
        );
      }
    });
  }
}
