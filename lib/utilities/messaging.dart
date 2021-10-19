import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:paladinsedge/app_theme.dart' as app_theme;
import 'package:paladinsedge/constants.dart' as constants;

abstract class Messaging {
  static FirebaseMessaging? messaging;
  static NotificationSettings? settings;

  static Future<String?> initMessaging() async {
    if (constants.isWeb) return null; // don't run on web

    messaging = FirebaseMessaging.instance;

    settings = await messaging!.requestPermission(
      sound: true,
      provisional: true,
    );

    if (settings?.authorizationStatus != AuthorizationStatus.authorized) {
      return null;
    }
    final token = await messaging!.getToken();
    return token;
  }

  static Future<void> _backgroundMessageHandler(RemoteMessage message) async {}

  static void onMessage() {
    // register in main() before runApp()
    FirebaseMessaging.onMessage.listen((message) {
      HapticFeedback.vibrate();
      showSimpleNotification(
        Text("${message.notification?.title}"),
        trailing: Image.network(message.notification!.android!.imageUrl!),
        duration: const Duration(seconds: 6),
        background: app_theme.themeMaterialColor,
      );
    });
  }

  static void onBackgroundMessage() {
    // register in main() before runApp()
    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  }
}
