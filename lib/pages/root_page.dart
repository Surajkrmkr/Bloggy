import 'package:blogy/authentication/pages/sign_up_page.dart';
import 'package:blogy/navigation/pages/navigation_page.dart';
import 'package:blogy/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class RootPage extends StatelessWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(snapshot.hasData) {
            // CollectionReference _user = FirebaseFirestore.instance.collection('users');
            return Home();
          }
          else if(snapshot.hasError){
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          else{
              return const SignUpPage();
          }
        },
      ),
    );
  }
}
