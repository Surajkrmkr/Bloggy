import 'package:blogy/blog%20post/model/blog_model.dart';
import 'package:blogy/blog%20post/pages/post_blog_page.dart';
import 'package:blogy/blog%20post/widget/blog.dart';
import 'package:blogy/blog%20post/widget/full_blog_view.dart';
import 'package:blogy/users/controller/auth_user.dart';
import 'package:blogy/themes/colors.dart';
import 'package:blogy/themes/fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileBlogs extends StatelessWidget {
  const ProfileBlogs({
    Key? key,
    required this.name,
  }) : super(key: key);
  final String? name;
  // final Stream<QuerySnapshot> blog = FirebaseFirestore.instance
  //     .collection('users')
  //     .doc(FirebaseAuth.instance.currentUser!.displayName)
  //     .collection('post')
  //     .orderBy('id', descending: true)
  //     .snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(name)
            .collection('post')
            .orderBy('id', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Expanded(
                child: Center(child: CircularProgressIndicator()));
          } else if (snapshot.hasError) {
            return const Expanded(child: Center(child: Text("Error")));
          } else if (snapshot.hasData) {
            var data = snapshot.data!.docs;
            if (data.isEmpty) {
              return Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "No Blogs Yet",
                        textAlign: TextAlign.center,
                        style: MyFont.getTextStyle(
                            19, Colors.black, FontWeight.normal),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      name == FirebaseAuth.instance.currentUser!.displayName
                          ? ElevatedButton(
                              onPressed: () async {
                                Get.to(() => PostBlogPage());
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.greenAccent,
                                  onPrimary: Colors.white,
                                  minimumSize: const Size(130, 40)),
                              child: const Text('ADD BLOG'))
                          : const SizedBox()
                    ],
                  ),
                ),
              );
            }
            return Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, i) {
                  final blogItem = data[i];
                  return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      height: 200,
                      width: Get.width * 0.6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: MyColors.accentColor.withOpacity(0.1),
                      ),
                      child: GestureDetector(
                          onTap: () {
                            BlogModel _blog = BlogModel(
                              id: blogItem['id'],
                              title: blogItem['title'],
                              desc: blogItem['desc'],
                              author: blogItem['author'],
                              category: blogItem['category'],
                              img: blogItem['img'],
                            );

                            Get.to(() => FullBlogView(blog: _blog));
                          },
                          child: BlogWidget(blogItem: blogItem)));
                },
              ),
            );
          }
          return Container();
        });
  }
}
