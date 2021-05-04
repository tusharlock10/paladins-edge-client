import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

abstract class Messaging {
  static FirebaseMessaging? messaging;
  static NotificationSettings? settings;

  static Future<String?> initMessaging() async {
    if (kIsWeb) return null; // don't run on web

    messaging = FirebaseMessaging.instance;

    settings = await messaging!.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        sound: true,
        provisional: true);
    if (settings?.authorizationStatus != AuthorizationStatus.authorized) {
      return null;
    }

    final token = await messaging!.getToken();

    return token;
  }
}
