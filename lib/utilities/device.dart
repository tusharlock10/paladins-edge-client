import "dart:io";

import "package:dartx/dartx.dart";
import "package:device_info_plus/device_info_plus.dart";
import "package:paladinsedge/constants.dart" as constants;
import "package:paladinsedge/models/index.dart" as models;

Future<models.DeviceDetail?> getDeviceDetail() async {
  final device = DeviceInfoPlugin();
  final deviceInfo = await device.deviceInfo;
  final result = deviceInfo.toMap().filterValues(
        (value) => value is String || value is int || value is double,
      );

  if (constants.isWeb) {
    return models.DeviceDetail(
      platform: "web",
      webDeviceInfo: result,
    );
  }
  if (Platform.isAndroid) {
    return models.DeviceDetail(
      platform: "android",
      androidDeviceInfo: result,
    );
  }

  return null;
}
