import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initialize(context) {
    // initializationSettings for Android
    const InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    );

    /// TODO initialize method
    _notificationsPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: ( route) async {
      log("onSelectNotification");
      if (route == null) {
        Get.to(route);

        log("Router Value: $route");

        //////// DemoScreen in case of Foreground Message ///////////////////
        // Navigator.of(context).push(
        //   MaterialPageRoute(builder: (context) => DemoScreen(id: id)),
        // );
        ////////////////////////////////////////////////////////////////////
      }
    });
  }

  static void initState(context){

    /// TODO Terminated State
    /// 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and
    // you can get notification data in this method
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print("FirebaseMessaging.instance.getInitialMessage");
      if (message != null) {
        final routeFromMessage = message.data["route"];
        Navigator.of(context).pushNamed(routeFromMessage);
        LocalNotificationService.createAndDisplayNotification(message);
      }
    });

    /// TODO Foreground State
    /// 2. This method only call when App in foreground it mean app must be opened
    FirebaseMessaging.onMessage.listen((message) {
      print("FirebaseMessaging.onMessage.listen");
      if (message.notification != null) {
        LocalNotificationService.createAndDisplayNotification(message);
      }
    });

    /// TODO Background State
    /// 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message.notification != null) {
        LocalNotificationService.createAndDisplayNotification(message);
      }
    });
  }

  static void createAndDisplayNotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          // "com.example.flutter_push_notification_app",
          "flutter_push_notification_app",
          "flutter_push_notification_app",
          importance: Importance.max,
          priority: Priority.high,
        ),
      );

      /// pop up show
      await _notificationsPlugin.show(
        id,
        message.data["title"] ?? message.notification?.title ?? "Title",
        message.notification!.body,
        notificationDetails,
        payload: message.data["route"],

        //////// In case of DemoScreen //////////////////////////////////////
        // this "id" key and "id" key of passing firebase's data must same
        // payload: message.data["_id"],
        ////////////////////////////////////////////////////////////////////
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}