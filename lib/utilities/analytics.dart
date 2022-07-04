import "package:firebase_analytics/firebase_analytics.dart";
import "package:flutter/foundation.dart";

abstract class Analytics {
  static Future<void> logScreenEntry(String screenName) async {
    debugPrint("ANALYTICS [screen_view] : $screenName");
    await FirebaseAnalytics.instance.logScreenView(
      screenName: screenName,
    );
  }

  static Future<void> logEvent(
    String name, [
    Map<String, dynamic>? parameters,
  ]) async {
    debugPrint("ANALYTICS [$name] : $parameters");
    await FirebaseAnalytics.instance.logEvent(
      name: name,
      parameters: parameters,
    );
  }

  static Future<void> setUserId(String id) async {
    debugPrint("ANALYTICS [set_user_id] : $id");
    await FirebaseAnalytics.instance.setUserId(id: id);
  }
}
