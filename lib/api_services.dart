import 'dart:convert';

import 'package:http/http.dart' as http;
class APIService{
  postData(String message, String userDeviceToken, String userName) async {
    try {
      var response = await http.post(
          Uri.parse("https://fcm.googleapis.com/fcm/send"),
          headers: {
            "Authorization": "key=your key",
            "Content-Type": "application/json",
          },
          body: jsonEncode(
              {
                "notification": {
                  "title": userName.toString(),
                  "body": message.toString(),
                  "click_action": "OPEN_ACTIVITY_1"
                },
                "data": {
                  "message": message.toString(),
                },
                "to": userDeviceToken.toString()
              }
          ));
      print(response.statusCode);
      print(response.body);
    } catch (e) {
      print(e);
    }
  }
}