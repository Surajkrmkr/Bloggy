import 'package:blogy/blog%20post/model/blog_model.dart';
import 'package:blogy/blog%20post/widget/blog.dart';
import 'package:blogy/blog%20post/widget/full_blog_view.dart';
import 'package:blogy/themes/colors.dart';
import 'package:blogy/themes/fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageBlog extends StatelessWidget {
  const HomePageBlog({
    Key? key,
    this.blog,
  }) : super(key: key);

  final Stream<QuerySnapshot>? blog;

  //  = FirebaseFirestore.instance
  //     .collection('bloggy')
  //     .orderBy('id', descending: true)
  //     .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: blog,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error"));
          } else if (snapshot.hasData) {
            var data = snapshot.data!.docs;
            return ListView.builder(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, i) {
                final blogItem = data[i];
                return GestureDetector(
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
                  child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: 400,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: MyColors.accentColor.withOpacity(0.1),
                      ),
                      child: BlogWidget(blogItem: blogItem)),
                );
              },
            );
          }
          return Container();
        });
  }
}
