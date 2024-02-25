import "package:flutter/foundation.dart";

/// Used to track time
class Stopwatch {
  static final Map<String, DateTime> _timers = {};

  /// Starts a timer if not present, else stops the timer and tells the time taken
  static void startStopTimer(String key) {
    final timer = _timers.remove(key);
    if (timer == null) {
      Stopwatch._timers[key] = DateTime.now();
    } else {
      final duration = DateTime.now().difference(timer);
      debugPrint("$key took ${duration.inMilliseconds} ms");
    }
  }
}
