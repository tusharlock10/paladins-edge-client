import "package:firebase_analytics/firebase_analytics.dart";
import "package:flutter/foundation.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/utilities/index.dart" as utilities;

abstract class Analytics {
  static var analyticsEnabled = false;

  static Future<void> initialize() async {
    if (constants.isWindows) return;

    utilities.Stopwatch.startStopTimer("initializeAnalytics");
    analyticsEnabled = !constants.isDebug;
    await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(
      analyticsEnabled,
    );
    utilities.Stopwatch.startStopTimer("initializeAnalytics");

    return;
  }

  static Future<void> logScreenEntry(String screenName) async {
    if (!analyticsEnabled) return;

    debugPrint("ANALYTICS [screen_view] : $screenName");
    await FirebaseAnalytics.instance.logScreenView(
      screenName: screenName,
    );
  }

  static Future<void> logEvent(
    String name, [
    Map<String, dynamic>? parameters,
  ]) async {
    if (!analyticsEnabled) return;

    debugPrint("ANALYTICS [$name] : $parameters");
    await FirebaseAnalytics.instance.logEvent(
      name: name,
      parameters: parameters,
    );
  }

  static Future<void> setUserId(String id) async {
    if (!analyticsEnabled) return;

    debugPrint("ANALYTICS [set_user_id] : $id");
    await FirebaseAnalytics.instance.setUserId(id: id);
  }
}
