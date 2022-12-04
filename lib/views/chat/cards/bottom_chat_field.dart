import 'dart:io';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tiktok_clone/api_services.dart';
import 'package:tiktok_clone/controllers/chat/chat_controller.dart';
import 'package:tiktok_clone/enums/message_enum.dart';
import 'package:tiktok_clone/models/message_reply.dart';
import 'package:tiktok_clone/utils/utils.dart';
import 'package:tiktok_clone/views/chat/cards/reply_card.dart';

class BottomChatField extends ConsumerStatefulWidget {
  final String recieverUserId;
  final bool isGroupChat;
  final String deviceToken;
  final String name;
  const BottomChatField({
    Key? key,
    required this.recieverUserId,
    required this.isGroupChat,
    required this.deviceToken,
    required this.name,
  }) : super(key: key);

  @override
  ConsumerState<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends ConsumerState<BottomChatField> {
  bool isShowSendButton = false;
  final TextEditingController _messageController = TextEditingController();
  bool isRecorderInit = false;
  bool isShowEmojiContainer = false;
  bool isRecording = false;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }



  void sendTextMessage() async {
    if (isShowSendButton) {
      APIService().postData(  _messageController.text.trim(), widget.deviceToken, widget.name);

      ref.read(chatControllerProvider).sendTextMessage(
        context,
        _messageController.text.trim(),
        widget.recieverUserId,
        widget.isGroupChat,
      );
      setState(() {
        _messageController.text = '';
      });
    }
  }

  void sendFileMessage(
      File file,
      MessageEnum messageEnum,
      ) {
    ref.read(chatControllerProvider).sendFileMessage(
      context,
      file,
      widget.recieverUserId,
      messageEnum,
      widget.isGroupChat,
    );
  }

  void selectImage() async {
    File? image = await pickImageFromGallery(context);
    if (image != null) {
      sendFileMessage(image, MessageEnum.image);
    }
  }

  void selectVideo() async {
    File? video = await pickVideoFromGallery(context);
    if (video != null) {
      sendFileMessage(video, MessageEnum.video);
    }
  }


  void hideEmojiContainer() {
    setState(() {
      isShowEmojiContainer = false;
    });
  }

  void showEmojiContainer() {
    setState(() {
      isShowEmojiContainer = true;
    });
  }

  void showKeyboard() => focusNode.requestFocus();
  void hideKeyboard() => focusNode.unfocus();

  void toggleEmojiKeyboardContainer() async{
    if (isShowEmojiContainer) {
      showKeyboard();
      hideEmojiContainer();

    } else {
      hideKeyboard();
      await Future.delayed(Duration(milliseconds: 800)).then((value) {
        showEmojiContainer();

      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
    isRecorderInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final messageReply = ref.watch(messageReplyProvider);
    final isShowMessageReply = messageReply != null;
    return Column(
      children: [
        isShowMessageReply ? const MessageReplyPreview() : const SizedBox(),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                focusNode: focusNode,
                controller: _messageController,
                style: TextStyle(
                  color: Colors.black
                ),
                onTap: toggleEmojiKeyboardContainer,
                onChanged: (val) {
                  if (val.isNotEmpty) {
                    setState(() {
                      isShowSendButton = true;
                    });
                  } else {
                    setState(() {
                      isShowSendButton = false;
                    });
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SizedBox(
                      width: 30,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: toggleEmojiKeyboardContainer,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Icon(
                                Icons.emoji_emotions,
                                color: Colors.grey[800],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  suffixIcon: SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: selectImage,
                          icon: Icon(
                            Icons.camera_alt,
                            color: Colors.grey[800],
                          ),
                        ),
                        IconButton(
                          onPressed: selectVideo,
                          icon: Icon(
                            Icons.videocam_rounded,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                  hintText: 'Type a message!',
                  hintStyle: TextStyle(
                    color: Colors.grey[800],
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(10),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 8,
                right: 2,
                left: 2,
              ),
              child: CircleAvatar(
                backgroundColor: const Color(0xFF128C7E),
                radius: 25,
                child: GestureDetector(
                  child: Icon(
                     Icons.send,
                    color: Colors.white,
                  ),
                  onTap: sendTextMessage,
                ),
              ),
            ),
          ],
        ),
        isShowEmojiContainer
            ? SizedBox(
          height: 310,
          child: EmojiPicker(
            onEmojiSelected: ((category, emoji) {
              setState(() {
                _messageController.text =
                    _messageController.text + emoji.emoji;
              });

              if (!isShowSendButton) {
                setState(() {
                  isShowSendButton = true;
                });
              }
            }),
          ),
        )
            : const SizedBox(),
      ],
    );
  }
}