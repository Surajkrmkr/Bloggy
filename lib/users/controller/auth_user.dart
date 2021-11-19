import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthUser extends GetxController {
  Rx<User?> user = FirebaseAuth.instance.currentUser.obs;

  addUsertoBloggy() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.value!.displayName)
        .set({
      'name': user.value?.displayName,
      'email': user.value?.email,
    });
  }
}

class OtherUser {
  String? name;
  String? email;
  OtherUser({this.name, this.email});
}
