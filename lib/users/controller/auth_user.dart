import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthUser extends GetxController {
  Rx<User?> user = FirebaseAuth.instance.currentUser.obs;
  @override
  onInit() {
   user.value!.displayName??user.value!.updateDisplayName(user.value!.email);
    user.value!.photoURL??user.value!.updatePhotoURL("https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-Download-Image.png"); 
    super.onInit();
  }

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
