import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/controllers/search_controller.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/models/user.dart';
import 'package:tiktok_clone/views/screens/profile_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final SearchController searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: CupertinoTextField(
            onSubmitted:  (value) => searchController.searchUser(value),
            style: TextStyle(
                color: Colors.white
            ),
            keyboardType: TextInputType.text,
            placeholder: "Search",
            placeholderStyle: TextStyle(
              color: Colors.white,
            ),
            prefix: Padding(
              padding:
              const EdgeInsets.fromLTRB(9.0, 6.0, 9.0, 6.0),
              child: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white38,
            ),
          ),
        ),
        body: searchController.searchedUsers.isEmpty
            ?  Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search, color: Colors.white38, size: 60,),
                    Text(
                      'Search for users!',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white38

                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: searchController.searchedUsers.length,
                itemBuilder: (context, index) {
                  User user = searchController.searchedUsers[index];
                  return InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(uid: user.uid),
                      ),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          user.profilePhoto,
                        ),
                      ),
                      title: Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
      );
    });
  }
}
