import "package:firebase_remote_config/firebase_remote_config.dart";
import "package:paladinsedge/constants.dart" as constants;

abstract class RemoteConfig {
  static final _firebaseRemoteConfig = FirebaseRemoteConfig.instance;
  static const _remoteConfigDefaults = {
    constants.RemoteConfigParams.enableGuestLogin: true,
  };

  /// Getters
  static bool get enableGuestLogin => _firebaseRemoteConfig
      .getBool(constants.RemoteConfigParams.enableGuestLogin);

  /// Setup for Remote Config

  static Future<bool> initialize() {
    _firebaseRemoteConfig.setDefaults(_remoteConfigDefaults);

    return _firebaseRemoteConfig.fetchAndActivate();
  }
}
