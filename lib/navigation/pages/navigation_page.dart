import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:blogy/navigation/controller/navigation_controller.dart';
import 'package:blogy/blog%20post/pages/post_blog_page.dart';
import 'package:blogy/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  final NavigationController navigationController =
      Get.put(NavigationController());

  Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          body: navigationController
              .pages[navigationController.selectedItemPos.value],
          floatingActionButton: FloatingActionButton(
            backgroundColor: MyColors.accentColor,
            onPressed: () {
              Get.to(() => PostBlogPage());
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: Obx(() {
            return SizedBox(
              height: 60,
              child: AnimatedBottomNavigationBar(
                icons: const [Icons.home, Icons.search, Icons.menu, Icons.home],
                onTap: (index) {
                  navigationController.changeIndex(index);
                },
                activeColor: MyColors.accentColor,
                gapLocation: GapLocation.center,
                notchSmoothness: NotchSmoothness.softEdge,
                leftCornerRadius: 25,
                rightCornerRadius: 25,
                splashColor: MyColors.accentColor.withOpacity(0.5),
                activeIndex: navigationController.selectedItemPos.value,
              ),
            );
          }));
    });
  }
}
