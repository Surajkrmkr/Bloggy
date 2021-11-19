import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class FirebaseApi {
  static UploadTask? uploadFile(
      String destination, File file, FirebaseStorage storage) {
    try {
      var output = storage.ref().child('$destination/${basename(file.path)}').putFile(file);
      return output;
    } on Exception catch (e) {
      Get.snackbar('Something', 'went wrong');
    }
  }
}
