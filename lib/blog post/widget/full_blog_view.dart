import 'package:blogy/blog%20post/model/blog_model.dart';
import 'package:blogy/themes/fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FullBlogView extends StatelessWidget {
  const FullBlogView({Key? key, this.blog}) : super(key: key);
  final BlogModel? blog;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: blog!.img!,
            height: Get.height,
            width: Get.width,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(1),
                  Colors.black.withOpacity(0),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            height: Get.height,
            width: Get.width,
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            child: Padding(
              padding: EdgeInsets.only(
                  top: Get.height * 0.5, left: 20, right: 20, bottom: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    blog!.title!,
                    style:
                        MyFont.getTextStyle(25, Colors.white, FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    blog!.desc!,
                    style: MyFont.getTextStyle(
                        20, Colors.white.withOpacity(0.7), FontWeight.normal),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'By ' + blog!.author!,
                    style: MyFont.getTextStyle(
                        22, Colors.white.withOpacity(0.7), FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back_ios),
              color: Colors.white,
            ),
          ),
          Positioned(
            bottom: 0,
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(1),
                      Colors.black.withOpacity(0),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                height: 300,
                width: Get.width,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
