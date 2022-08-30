import "package:firebase_remote_config/firebase_remote_config.dart";
import "package:paladinsedge/constants/index.dart" as constants;

abstract class RemoteConfig {
  static final _firebaseRemoteConfig = FirebaseRemoteConfig.instance
    ..setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(minutes: 5),
      ),
    );
  static const _remoteConfigDefaults = {
    constants.RemoteConfigParams.enableGuestLogin: true,
    constants.RemoteConfigParams.paladinsApiUnavailable: false,
    constants.RemoteConfigParams.serverMaintenance: false,
  };

  /// Getters
  static bool get enableGuestLogin => _firebaseRemoteConfig
      .getBool(constants.RemoteConfigParams.enableGuestLogin);
  static bool get showBackgroundSplash => _firebaseRemoteConfig
      .getBool(constants.RemoteConfigParams.showBackgroundSplash);
  static bool get paladinsApiUnavailable => _firebaseRemoteConfig
      .getBool(constants.RemoteConfigParams.paladinsApiUnavailable);
  static bool get serverMaintenance => _firebaseRemoteConfig
      .getBool(constants.RemoteConfigParams.serverMaintenance);

  /// Setup for Remote Config

  static Future<bool> initialize() {
    _firebaseRemoteConfig.setDefaults(_remoteConfigDefaults);

    return _firebaseRemoteConfig.fetchAndActivate();
  }
}
