import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tiktok_clone/controllers/chat/chat_controller.dart';
import 'package:tiktok_clone/models/chat.dart';
import 'package:tiktok_clone/views/chat/chat_screen.dart';

class MessageScreen extends ConsumerStatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends ConsumerState<MessageScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Messages", style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold
        ),),
      ),
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: Divider(),),
          StreamBuilder<List<ChatContact>>(
              stream: ref.watch(chatControllerProvider).chatContacts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SliverFillRemaining(child: Center(child: CircularProgressIndicator(
                    color: Colors.white,
                  )));
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      var chatContactData = snapshot.data![index];
                      if(!snapshot.hasData){
                        return SliverToBoxAdapter(
                          child: Center(child: Text("No messages yet",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                letterSpacing: 1
                            ),
                          )),
                        );
                      }
                      else{
                        return snapshot.data![index].name.toLowerCase().contains(searchController.text) ?
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MobileChatScreen(
                                name: chatContactData.name,
                                uid: chatContactData.uid,
                                deviceToken: chatContactData.deviceToken,
                                isGroupChat: false,
                                profilePic: chatContactData.profilePic)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: ListTile(
                              title: Text(
                                chatContactData.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Text(
                                  chatContactData.lastMessage,
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  chatContactData.profilePic,
                                ),
                                radius: 30,
                              ),
                              trailing: Text(
                                DateFormat.Hm()
                                    .format(chatContactData.timeSent),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ) : Container();
                      }
                    },
                    // 40 list items
                    childCount: snapshot.data!.length,
                  ),
                );
              }),
        ],
      ),
    );
  }
}
