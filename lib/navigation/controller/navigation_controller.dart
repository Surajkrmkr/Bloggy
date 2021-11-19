import 'package:blogy/category/pages/category_filter_page.dart';
import 'package:blogy/pages/about_page.dart';
import 'package:blogy/pages/home_page.dart';
import 'package:blogy/profile/profile_page.dart';
import 'package:blogy/search/pages/search_page.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  var selectedItemPos = 0.obs;

  var pages =
      [HomePage(), SearchPage(), const CategoryFilterPage(), const AboutPage()].obs;

  changeIndex(i) {
    selectedItemPos.value = i;
  }
}
