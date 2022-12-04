class ChatContact {
  final String name;
  final String profilePic;
  final String uid;
  final DateTime timeSent;
  final String lastMessage;
  final String deviceToken;
  ChatContact({
    required this.name,
    required this.profilePic,
    required this.uid,
    required this.timeSent,
    required this.lastMessage,
    required this.deviceToken,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profilePic': profilePic,
      'uid': uid,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'lastMessage': lastMessage,
      'userDeviceToken': deviceToken,
    };
  }

  factory ChatContact.fromMap(Map<String, dynamic> map) {
    return ChatContact(
      name: map['name'] ?? '',
      profilePic: map['profilePic'] ?? '',
      uid: map['uid'] ?? '',
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
      lastMessage: map['lastMessage'] ?? '',
      deviceToken: map['userDeviceToken'] ?? '',
    );
  }
}