import 'package:blogy/themes/colors.dart';
import 'package:blogy/themes/fonts.dart';
import 'package:flutter/material.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
          ),
          child: Text(
            "About Me",
            style:
                MyFont.getTextStyle(30, MyColors.accentColor, FontWeight.bold),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/dev.jpg'),
              radius: 50,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Suraj Karmakar',
            style:
                MyFont.getTextStyle(22, MyColors.accentColor, FontWeight.bold),
          ),
          SizedBox(
            height: 60,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  launch('mailto:<Surajkarmakar2000@gmail.com>');
                },
                icon: Icon(
                  SimpleIcons.gmail,
                  size: 40,
                ),
                color: MyColors.accentColor,
              ),
              IconButton(
                onPressed: () {
                  launch('https://github.com/Surajkrmkr');
                },
                icon: Icon(
                  SimpleIcons.github,
                  size: 40,
                ),
                color: MyColors.accentColor,
              ),
              IconButton(
                onPressed: () {
                  launch('https://instagram.com/Surajkrmkr');
                },
                icon: Icon(
                  SimpleIcons.instagram,
                  size: 40,
                ),
                color: MyColors.accentColor,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            child: Text(
              "Made with Flutter ❤️",
              style: MyFont.getTextStyle(
                  25, MyColors.accentColor, FontWeight.normal),
            ),
          )
        ],
      ),
    );
  }
}
