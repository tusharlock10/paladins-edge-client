import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:overlay_support/overlay_support.dart';
import 'package:paladinsedge/app_theme.dart' as app_theme;
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/widgets/index.dart' as widgets;
import 'package:path_provider/path_provider.dart';

abstract class Messaging {
  static final flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
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

  static Future<void> _backgroundMessageHandler(RemoteMessage? message) async {
    // http.get(Uri.parse(constants.Env.baseUrl));
    if (message == null) {
      createNewNotif(
        title: "No message",
        body: "getInitialMessage",
      );
      return;
    }

    final data =
        message.data.map((key, value) => MapEntry(key, value?.toString()));
    debugPrint(data.toString());

    createNewNotif(
      imageUrl: data['imageUrl'],
      title: data['title'],
      body: data['body'],
    );
  }

  static Future<FilePathAndroidBitmap> _getFileAndroidBitmap(String url) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/notifLargeIcon';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return FilePathAndroidBitmap(filePath);
  }

  static void onMessage() {
    // register in main() before runApp()

    FirebaseMessaging.onMessage.listen((message) {
      final data =
          message.data.map((key, value) => MapEntry(key, value?.toString()));
      final imageUrl = data['imageUrl'];
      final title = data['title'];
      final body = data['body'];

      if (imageUrl == null) return;

      HapticFeedback.vibrate();
      showSimpleNotification(
        Column(
          children: [Text("$title"), Text("$body")],
        ),
        trailing: widgets.ElevatedAvatar(
          size: 24,
          borderRadius: 5,
          imageUrl: imageUrl,
        ),
        duration: const Duration(seconds: 5),
        background: app_theme.themeMaterialColor,
      );
    });
  }

  static void onBackgroundMessage() async {
    // register in main() before runApp()
    FirebaseMessaging.instance
        .getInitialMessage()
        .then(_backgroundMessageHandler);
    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  }

  static void createNewNotif({
    String? title,
    String? body,
    String? imageUrl,
  }) async {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      constants.NotificationChannels.friends,
      constants.NotificationChannels.friends,
      importance: Importance.max,
      priority: Priority.high,
      ticker: constants.NotificationChannels.friends,
      largeIcon:
          imageUrl != null ? await _getFileAndroidBitmap(imageUrl) : null,
    );
    final platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  static void registerLocalNotification() async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('ic_stat_ic_notification');
    const initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (event) {
      debugPrint('Event : $event');
    });
  }
}
