import 'package:blogy/users/controller/auth_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController{
  Rx<TextEditingController> searchController = TextEditingController().obs;
  var searchResults = [].obs;
  var searchedResults = [].obs;
}