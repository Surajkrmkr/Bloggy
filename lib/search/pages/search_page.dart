import 'package:blogy/profile/profile_page.dart';
import 'package:blogy/search/controller/search_controller.dart';
import 'package:blogy/themes/colors.dart';
import 'package:blogy/themes/fonts.dart';
import 'package:blogy/users/controller/auth_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final Future<QuerySnapshot<Map<String, dynamic>>> blog =
      FirebaseFirestore.instance.collection('users').get();

  final SearchController searchController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
          ),
          child: Text(
            "Search Bloggers",
            style:
                MyFont.getTextStyle(30, MyColors.accentColor, FontWeight.bold),
          ),
        ),
      ),
      body: Obx(() {
        return Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: TextField(
                  controller: searchController.searchController.value,
                  decoration: InputDecoration(
                    hintText: "Type here the name...",
                    hintStyle: MyFont.getTextStyle(
                      15,
                      Colors.grey,
                      FontWeight.normal,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (name) {
                    searchController.searchedResults.clear();
                    for (var i = 0;
                        i < searchController.searchResults.length;
                        i++) {
                      String search = searchController.searchResults[i]['name'];
                      if (search.toLowerCase().contains(name.toLowerCase())) {
                        searchController.searchedResults
                            .add(searchController.searchResults[i]);
                      }
                    }
                  }),
            ),
            StreamBuilder(
                stream: blog.asStream(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("Error"));
                  } else {
                    for (var element in snapshot.data!.docs) {
                      searchController.searchResults.add(element);
                    }
                    return Expanded(
                        child:
                            SearchListView(searchController: searchController));
                  }
                }),
          ],
        );
      }),
    );
  }
}

class SearchListView extends StatelessWidget {
  const SearchListView({
    Key? key,
    required this.searchController,
  }) : super(key: key);

  final SearchController searchController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (searchController.searchedResults.isNotEmpty) {
        return ListView.builder(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          itemCount: searchController.searchedResults.length,
          itemBuilder: (context, index) {
            final details = searchController.searchedResults[index];
            return ListTile(
              onTap: () {
                Get.to(() => ProfilePage(
                      isUserItself: true,
                      otherUser: OtherUser(
                          email: details['email'], name: details['name']),
                    ));
              },
              leading: const CircleAvatar(
                child: Icon(Icons.person),
              ),
              title: Text(details['name']),
              subtitle: Text(details['email']),
            );
          },
        );
      }
      return ListView.builder(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        itemCount: searchController.searchResults.length,
        itemBuilder: (context, index) {
          final details = searchController.searchResults[index];
          return ListTile(
            onTap: () {
              Get.to(() => ProfilePage(
                    isUserItself: true,
                    otherUser: OtherUser(
                        email: details['email'], name: details['name']),
                  ));
            },
            leading: const CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: Text(details['name']),
            subtitle: Text(details['email']),
          );
        },
      );
    });
  }
}
