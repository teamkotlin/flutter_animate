import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        announcement: true,
        criticalAlert: true,
        carPlay: true,
        provisional: true,
        sound: true);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint("authorized");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint("provisional");
    } else {
      debugPrint("permission not granted");
    }
  }

  getFcmToken() async {
    var token = await messaging.getToken();
    debugPrint("fcm+=> $token");
  }

  void initFirebase() async {
    FirebaseMessaging.onMessage.listen((message) {
      debugPrint("event=>${message.notification!.title.toString()}");
      debugPrint("event=>${message.notification!.body.toString()}");
      if (Platform.isAndroid) {
        initLocalNotification(message);
      }
      showNotification(message);
    });
  }

  void initLocalNotification(RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings("@mipmap/ic_launcher");
    var iosInitializationSettings = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);
    await localNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) {
      debugPrint("payload+=> $payload");
      handleOnTap(message);
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    var androidNotificationDetails = AndroidNotificationDetails(
        Random.secure().nextInt(10000).toString(),
        "High Importance Notifications",
        channelDescription: "notification channel",
        importance: Importance.high,
        priority: Priority.high,
        ticker: "ticker");
    var iosNotificationDetails = const DarwinNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true);
    var notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);
    Future.delayed(Duration.zero, () {
      localNotificationsPlugin.show(0, message.notification!.title.toString(),
          message.notification!.body.toString(), notificationDetails);
    });
  }

  void handleOnTap(RemoteMessage message) {
    if (message.data['type'] == "notification") {
      //navigate to next screen
    }
  }

  Future<void> setupInteractMessage() async {
    //when app is terminated
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      handleOnTap(initialMessage);
    }
    //when app in in background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleOnTap(event);
    });
  }
}
