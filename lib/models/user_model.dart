import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String name;
  String profilePhoto;
  String email;
  String uid;
  String userDeviceToken;

  UserModel(
      {required this.name,
        required this.email,
        required this.uid,
        required this.profilePhoto,
        required this.userDeviceToken});

  Map<String, dynamic> toJson() => {
    "name": name,
    "profilePhoto": profilePhoto,
    "email": email,
    "uid": uid,
    "userDeviceToken": uid,
  };

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      uid: map['uid'] ?? '',
      profilePhoto: map['profilePhoto'] ?? '',
      email: map['email'] ?? '',
      userDeviceToken: map['userDeviceToken'] ?? '',
    );
  }
}


