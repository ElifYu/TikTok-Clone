import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/controllers/chat/auth/auth.dart';
import 'package:tiktok_clone/models/user_model.dart';
import 'package:tiktok_clone/views/chat/chat_list.dart';

import 'cards/bottom_chat_field.dart';


class MobileChatScreen extends ConsumerWidget {
  final String name;
  final String uid;
  final bool isGroupChat;
  final String profilePic;
  final String deviceToken;
  const MobileChatScreen({
    Key? key,
    required this.name,
    required this.uid,
    required this.isGroupChat,
    required this.profilePic,
    required this.deviceToken,
  }) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return  Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.5,
        title: isGroupChat
            ? Text(name)
            : StreamBuilder<UserModel>(
            stream: ref.read(authControllerProvider).userDataById(uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: const CircularProgressIndicator(
                  color: Colors.white,
                ));
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name),

                ],
              );
            }),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ChatList(
              recieverUserId: uid,
              isGroupChat: isGroupChat,
            ),
          ),
          BottomChatField(
            recieverUserId: uid,
            isGroupChat: isGroupChat,
            deviceToken: deviceToken,
            name: name
          ),
        ],
      ),
    );
  }
}