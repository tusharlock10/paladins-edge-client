import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
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

  static void onMessage() {
    // register in main() before runApp()

    FirebaseMessaging.onMessage.listen((message) {
      final data =
          message.data.map((key, value) => MapEntry(key, value?.toString()));
      final imageUrl = data['imageUrl'];
      final title = data['title'];
      final body = data['body'];

      if (imageUrl == null || title == null || body == null) return;

      HapticFeedback.vibrate();
      widgets.showForegroundNotification(
        title: title,
        body: body,
        imageUrl: imageUrl,
      );
    });
  }

  static void onBackgroundMessage() async {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then(_backgroundMessageHandler);
    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  }

  static void createNotification({
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
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  static Future<void> _backgroundMessageHandler(RemoteMessage? message) async {
    if (message == null) return;

    final data =
        message.data.map((key, value) => MapEntry(key, value?.toString()));

    createNotification(
      imageUrl: data['imageUrl'],
      title: data['title'],
      body: data['body'],
    );
  }

  static Future<FilePathAndroidBitmap> _getFileAndroidBitmap(String url) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/notificationLargeIcon';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);

    return FilePathAndroidBitmap(filePath);
  }
}
