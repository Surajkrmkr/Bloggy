import 'package:blogy/authentication/widgets/sign_up_form.dart';
import 'package:blogy/themes/colors.dart';
import 'package:blogy/themes/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_icons/simple_icons.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: Image.network(
                "https://images.hdqwalls.com/download/stripes-dark-purple-6o-480x854.jpg",
                height: Get.height * 0.6,
                width: Get.width,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: Get.height * 0.6,
                width: Get.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(30.0),
                  child: SignUpFormWidget(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

