import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/models/user_model.dart';
import 'package:tiktok_clone/views/chat/chat_screen.dart';


final selectContactsRepositoryProvider = Provider(
      (ref) => SelectContactRepository(
    firestore: FirebaseFirestore.instance,
  ),
);

class SelectContactRepository {
  final FirebaseFirestore firestore;

  SelectContactRepository({
    required this.firestore,
  });


  void selectContact(UserModel selectedContact, BuildContext context) async {
    try {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MobileChatScreen(
          name: selectedContact.name,
          uid: selectedContact.uid,
          isGroupChat: false,
          deviceToken: selectedContact.userDeviceToken,
          profilePic: selectedContact.profilePhoto)));

    } catch (e) {
      Get.snackbar(
        'Oops!',
       e.toString()
      );
    }
  }
}