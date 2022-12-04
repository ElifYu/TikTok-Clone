import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/user_model.dart';
import 'package:tiktok_clone/utils/background_gradient.dart';
import 'package:tiktok_clone/views/widgets/custom_icon.dart';

import '../../models/user.dart';

class HomeScreen extends StatefulWidget {
  final String? name;
  final String? uid;
  final String? email;
  final String? profilePhoto;
  HomeScreen({Key? key, this.email, this.profilePhoto, this.name, this.uid}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIdx = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   /*
    userModel = UserModel(
        name: widget.name.toString(),
        profilePhoto: widget.profilePhoto.toString(),
        email: widget.email.toString(),
        uid: widget.uid.toString(),
    );
    */
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: BottomNavigationBar(
          onTap: (idx) {
            setState(() {
              pageIdx = idx;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: backgroundColor,
          selectedItemColor: Color(0xFFFB2B54),
          unselectedItemColor: Colors.white,
          currentIndex: pageIdx,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 30),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search, size: 30),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: CustomIcon(),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message, size: 30),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 30),
              label: 'Profile',
            ),
          ],
        ),
        body: IndexedStack(
          index: pageIdx,
          children: pages,
        )
      ),
    );
  }
}
