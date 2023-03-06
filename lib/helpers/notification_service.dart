import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class NotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

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
    var token= await messaging.getToken();
    debugPrint("fcm+=> $token");
  }
}
