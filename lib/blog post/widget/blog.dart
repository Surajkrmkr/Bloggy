import 'package:blogy/category/controller/filter_controller.dart';
import 'package:blogy/navigation/controller/navigation_controller.dart';
import 'package:blogy/profile/profile_page.dart';
import 'package:blogy/themes/colors.dart';
import 'package:blogy/themes/fonts.dart';
import 'package:blogy/users/controller/auth_user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlogWidget extends StatelessWidget {
  const BlogWidget({
    Key? key,
    required this.blogItem,
  }) : super(key: key);

  final QueryDocumentSnapshot<Object?> blogItem;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(35), topRight: Radius.circular(35)),
          child: CachedNetworkImage(
            imageUrl: blogItem['img'],
            height: 250,
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) =>
                const Center(child: Icon(Icons.error)),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 200,
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(blogItem['title'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: MyFont.getTextStyle(
                          18, MyColors.accentColor, FontWeight.bold)),
                  Text(blogItem['desc'],
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: MyFont.getTextStyle(
                          14,
                          MyColors.accentColor.withOpacity(0.5),
                          FontWeight.bold)),
                  Flexible(
                    child: Wrap(
                      spacing: 10,
                      children: [
                        ActionChip(
                          onPressed: () {
                            if (blogItem['category'] == 'movies') {
                              final NavigationController navigationController =
                                  Get.find();
                              navigationController.selectedItemPos.value = 2;
                              final FilterController filterController =
                                  Get.find();
                              filterController.isMovies.value = true;
                            } else {
                              final NavigationController navigationController =
                                  Get.find();
                              navigationController.selectedItemPos.value = 2;
                              final FilterController filterController =
                                  Get.find();
                              filterController.isSports.value = true;
                            }
                          },
                          backgroundColor:
                              MyColors.accentColor.withOpacity(0.1),
                          label: Text(blogItem['category'],
                              style: MyFont.getTextStyle(
                                  14, MyColors.accentColor, FontWeight.bold)),
                        ),
                        ActionChip(
                          onPressed: () {
                            Get.to(() => ProfilePage(
                                  isUserItself: true,
                                  otherUser: OtherUser(
                                      name: blogItem['author'], email: ''),
                                ));
                          },
                          backgroundColor:
                              MyColors.accentColor.withOpacity(0.1),
                          label: Text(blogItem['author'],
                              style: MyFont.getTextStyle(
                                  14, MyColors.accentColor, FontWeight.bold)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
