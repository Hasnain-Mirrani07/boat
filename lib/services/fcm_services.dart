import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class FcmPushNotiService {
  static var client = http.Client();

  static Future fetchFcmDetail({
    required String message,
    required String friendFcmToken,
    required String title,
  }) async {
    Map<String, String> headers = {
      'Authorization':
          "key=AAAAg34FTko:APA91bGvcB7_tkJm5KD4tfv2GWUDBs3xEru20qjb5ChZpIrGjqTeTnvh5kaWHlH04mpN4ie6ClpK3V76kfwC_iRGPhnY8RZrxCUqJBQJS5eQmocQ6fX8juKLNI8DxZ19xvh5H2b3zmMK",
      'Content-Type': 'application/json'
    };

    Map userDatas = {
      "to": friendFcmToken,
      "collapse_key": "type_a",
      "notification": {"body": message, "title": title, "critical": true},
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "sound": "default",
        "body": message,
        "title": title,
        "content_available": true,
        "priority": "high",
        "badge": "1",
      },
      "android": {
        "notification": {"channel_id": "high_importance_channel"},
      }
    };

    // print(userDatas);
    var response = await client.post(
      Uri.parse("https://fcm.googleapis.com/fcm/send"),
      body: jsonEncode(userDatas),
      headers: headers,
    );

    try {
      if (response.body.isNotEmpty) {
        debugPrint(response.body);
        print(response.body + " this is body");
      } else {
        debugPrint("else");
        debugPrint(response.body);
        return null;
      }
    } catch (e) {
      print("error" + e.toString());
    }
  }
}