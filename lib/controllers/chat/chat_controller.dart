import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/controllers/auth_controller.dart';
import 'package:tiktok_clone/controllers/chat/repositories.dart';
import 'package:tiktok_clone/enums/message_enum.dart';
import 'package:tiktok_clone/models/chat.dart';
import 'package:tiktok_clone/models/device_token_model.dart';
import 'package:tiktok_clone/models/message.dart';
import 'package:tiktok_clone/models/message_reply.dart';
import 'package:tiktok_clone/models/user_model.dart';


final chatControllerProvider = Provider((ref) {
  final chatRepository = ref.watch(chatRepositoryProvider);
  return ChatController(
    chatRepository: chatRepository,
    ref: ref,
  );
});

class ChatController {
  final ChatRepository chatRepository;
  final ProviderRef ref;
  ChatController({
    required this.chatRepository,
    required this.ref,
  });

  Stream<List<ChatContact>> chatContacts() {
    return chatRepository.getChatContacts();
  }


  Stream<List<Message>> chatStream(String recieverUserId) {
    return chatRepository.getChatStream(recieverUserId);
  }


  void sendTextMessage(
      BuildContext context,
      String text,
      String recieverUserId,
      bool isGroupChat,
      ) {
    final messageReply = ref.read(messageReplyProvider);
    chatRepository.sendTextMessage(
      context: context,
      text: text,
      recieverUserId: recieverUserId,
      senderUser: UserModel(
        name: AuthController.instance.user.displayName.toString(),
        email: AuthController.instance.user.email.toString(),
        profilePhoto: AuthController.instance.user.photoURL.toString(),
        uid: AuthController.instance.user.uid.toString(),
        userDeviceToken: UserDeviceToken.deviceTokenOfUser
      ),
      messageReply: messageReply,
      isGroupChat: isGroupChat,
    );
    ref.read(messageReplyProvider.state).update((state) => null);
  }

  void sendFileMessage(
      BuildContext context,
      File file,
      String recieverUserId,
      MessageEnum messageEnum,
      bool isGroupChat,
      ) {
    final messageReply = ref.read(messageReplyProvider);
    chatRepository.sendFileMessage(
      context: context,
      file: file,
      recieverUserId: recieverUserId,
      senderUserData: UserModel(
        name: AuthController.instance.user.displayName.toString(),
        email: AuthController.instance.user.email.toString(),
        profilePhoto: AuthController.instance.user.photoURL.toString(),
        uid: AuthController.instance.user.uid.toString(),
        userDeviceToken: UserDeviceToken.deviceTokenOfUser
      ),
      messageEnum: messageEnum,
      ref: ref,
      messageReply: messageReply,
      isGroupChat: isGroupChat,
    );
    ref.read(messageReplyProvider.state).update((state) => null);
  }

  void sendGIFMessage(
      BuildContext context,
      String gifUrl,
      String recieverUserId,
      bool isGroupChat,
      ) {
    final messageReply = ref.read(messageReplyProvider);
    int gifUrlPartIndex = gifUrl.lastIndexOf('-') + 1;
    String gifUrlPart = gifUrl.substring(gifUrlPartIndex);
    String newgifUrl = 'https://i.giphy.com/media/$gifUrlPart/200.gif';

    chatRepository.sendGIFMessage(
      context: context,
      gifUrl: newgifUrl,
      recieverUserId: recieverUserId,
      senderUser: UserModel(
        name: AuthController.instance.user.displayName.toString(),
        email: AuthController.instance.user.email.toString(),
        profilePhoto: AuthController.instance.user.photoURL.toString(),
        uid: AuthController.instance.user.uid.toString(),
        userDeviceToken: UserDeviceToken.deviceTokenOfUser
      ),
      messageReply: messageReply,
      isGroupChat: isGroupChat,
    );
    ref.read(messageReplyProvider.state).update((state) => null);
  }

  void setChatMessageSeen(
      BuildContext context,
      String recieverUserId,
      String messageId,
      ) {
    chatRepository.setChatMessageSeen(
      context,
      recieverUserId,
      messageId,
    );
  }
}