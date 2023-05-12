import "dart:io";

import "package:android_id/android_id.dart";
import "package:dartx/dartx.dart";
import "package:device_info_plus/device_info_plus.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/models/index.dart" as models;

Future<models.DeviceDetail?> getDeviceDetail() async {
  final device = DeviceInfoPlugin();
  final deviceInfo = await device.deviceInfo;
  final result = deviceInfo.data.filterValues(
    (value) => value is String || value is int || value is double,
  );

  if (constants.isWeb) {
    return models.DeviceDetail(
      platform: "web",
      webDeviceInfo: result,
    );
  }
  if (Platform.isAndroid) {
    const androidIdPlugin = AndroidId();
    final androidId = await androidIdPlugin.getId();
    result["androidId"] = androidId ?? "Unknown";

    return models.DeviceDetail(
      platform: "android",
      androidDeviceInfo: result,
    );
  }

  return null;
}
