import "package:firebase_remote_config/firebase_remote_config.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:pub_semver/pub_semver.dart";

abstract class RemoteConfig {
  static FirebaseRemoteConfig? _firebaseRemoteConfig;

  /// Getters
  static bool get enableGuestLogin {
    const key = constants.RemoteConfigParams.enableGuestLogin;
    if (_firebaseRemoteConfig == null) return RemoteConfig.getDefaultValue(key);

    return _firebaseRemoteConfig!.getBool(key);
  }

  static bool get paladinsApiUnavailable {
    const key = constants.RemoteConfigParams.paladinsApiUnavailable;
    if (_firebaseRemoteConfig == null) return RemoteConfig.getDefaultValue(key);

    return _firebaseRemoteConfig!.getBool(key);
  }

  static bool get serverMaintenance {
    const key = constants.RemoteConfigParams.serverMaintenance;
    if (_firebaseRemoteConfig == null) return RemoteConfig.getDefaultValue(key);

    return _firebaseRemoteConfig!.getBool(key);
  }

  static Version get lowestSupportedVersion {
    const key = constants.RemoteConfigParams.lowestSupportedVersion;
    var version = RemoteConfig.getDefaultValue(key);

    if (_firebaseRemoteConfig != null) {
      version = _firebaseRemoteConfig!.getString(key);
    }

    return Version.parse(version);
  }

  /// Setup for Remote Config
  /// Initialization is disabled on windows
  static Future<void> initialize() async {
    if (constants.isWindows) return;

    final remoteConfigInstance = FirebaseRemoteConfig.instance
      ..setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(minutes: 5),
        ),
      );
    remoteConfigInstance.setDefaults(constants.remoteConfigDefaults);
    await remoteConfigInstance.fetchAndActivate();
    _firebaseRemoteConfig = remoteConfigInstance;
  }

  static getDefaultValue(String key) => constants.remoteConfigDefaults[key];
}
