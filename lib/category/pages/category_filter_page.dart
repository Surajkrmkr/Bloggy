import 'package:blogy/category/controller/filter_controller.dart';
import 'package:blogy/category/pages/filtered_blog.dart';
import 'package:blogy/themes/colors.dart';
import 'package:blogy/themes/fonts.dart';
import 'package:blogy/widgets/home_page_blogs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryFilterPage extends StatelessWidget {
  const CategoryFilterPage({Key? key}) : super(key: key);

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
            "Category",
            style:
                MyFont.getTextStyle(30, MyColors.accentColor, FontWeight.bold),
          ),
        ),
      ),
      body: FilterPage(),
    );
  }
}

class FilterPage extends StatelessWidget {
  FilterPage({
    Key? key,
  }) : super(key: key);
  final FilterController filterController = Get.put(FilterController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Obx(() {
        return Column(
          children: [
            Row(
              children: [
                Wrap(
                  spacing: 10,
                  children: [
                    ActionChip(
                      onPressed: () {
                        filterController.isMovies.value =
                            !filterController.isMovies.value;
                      },
                      backgroundColor: MyColors.accentColor.withOpacity(0.1),
                      label: Row(
                        children: [
                          Text('Movies',
                              style: MyFont.getTextStyle(
                                  14, MyColors.accentColor, FontWeight.bold)),
                          filterController.isMovies.value
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Icon(
                                    Icons.cancel,
                                    color: MyColors.accentColor,
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                    ActionChip(
                      onPressed: () {
                        filterController.isSports.value =
                            !filterController.isSports.value;
                      },
                      backgroundColor: MyColors.accentColor.withOpacity(0.1),
                      label: Row(
                        children: [
                          Text('Sports',
                              style: MyFont.getTextStyle(
                                  14, MyColors.accentColor, FontWeight.bold)),
                          filterController.isSports.value
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Icon(
                                    Icons.cancel,
                                    color: MyColors.accentColor,
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Expanded(child: FilteredPage())
          ],
        );
      }),
    );
  }
}

