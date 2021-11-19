import 'package:blogy/authentication/controller/google_sign_in.dart';
import 'package:blogy/authentication/pages/sign_up_page.dart';
import 'package:blogy/pages/root_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GoogleSignInProvider(),
      child: const GetMaterialApp(
        title: 'Bloggy',
        home: RootPage(),
      ),
    );
  }
}
