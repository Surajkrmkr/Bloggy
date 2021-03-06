import 'package:blogy/authentication/controller/google_sign_in.dart';
import 'package:blogy/authentication/pages/sign_in_page.dart';
import 'package:blogy/themes/colors.dart';
import 'package:blogy/themes/fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:simple_icons/simple_icons.dart';

class SignUpFormWidget extends StatelessWidget {
  SignUpFormWidget({
    Key? key,
  }) : super(key: key);
  EmailSignIn emailSignIn = Get.put(EmailSignIn());
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text("Get Started",
                  style: MyFont.getTextStyle(
                      30, MyColors.accentColor, FontWeight.bold)),
            ),
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              controller: emailSignIn.email.value,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle:
                    MyFont.getTextStyle(20, Colors.grey, FontWeight.bold),
              ),
              validator: (value) {
                if (value!.isEmpty || !value.contains('@')) {
                  return 'Enter valid email';
                }
                return null;
              },
            ),
            TextFormField(
              controller: emailSignIn.password.value,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle:
                    MyFont.getTextStyle(20, Colors.grey, FontWeight.bold),
              ),
              validator: (value) {
                if (value!.isEmpty || value.length < 6) {
                  return 'Enter Password correctly of 6 characters';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("or Sign up with"),
                  IconButton(
                    onPressed: () {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      provider.googleLogin();
                    },
                    icon: Icon(SimpleIcons.google, color: MyColors.accentColor),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Sign Up",
                  style: MyFont.getTextStyle(
                      20, MyColors.accentColor, FontWeight.bold),
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: MyColors.accentColor,
                  child: IconButton(
                    color: Colors.white,
                    iconSize: 40,
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          FirebaseAuth auth = FirebaseAuth.instance;
                          await auth.createUserWithEmailAndPassword(
                              email: emailSignIn.email.value.text,
                              password: emailSignIn.password.value.text);
                        } on Exception catch (e) {
                          Get.snackbar("Error", e.toString(),
                              snackPosition: SnackPosition.BOTTOM);
                        }
                      }
                    },
                    icon: const Icon(Icons.navigate_next),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Already signed up ?",
                    style:
                        MyFont.getTextStyle(16, Colors.grey, FontWeight.normal),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const SignInPage());
                    },
                    child: Text(
                      "Sign in",
                      style: MyFont.getTextStyle(
                          18, MyColors.accentColor, FontWeight.bold),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
