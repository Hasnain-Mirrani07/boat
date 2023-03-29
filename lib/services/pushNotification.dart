import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

class FirebasePushNotificationService {
  void initialize() {
    FirebaseMessaging.onMessage.listen((message) {
      log("FirebaseMessaging.onMessage.listen");
      if (message.notification != null) {
        log(message.notification!.title.toString());
        log(message.notification!.body.toString());
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      log("onMessage: $event");
    });
  }
}