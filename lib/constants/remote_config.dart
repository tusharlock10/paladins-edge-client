abstract class RemoteConfigParams {
  static const enableGuestLogin = "enableGuestLogin";
  static const showBackgroundSplash = "showBackgroundSplash";
  static const paladinsApiUnavailable = "paladinsApiUnavailable";
  static const serverMaintenance = "serverMaintenance";
  static const lowestSupportedVersion = "lowestSupportedVersion";
}

final remoteConfigDefaults = {
  RemoteConfigParams.enableGuestLogin: true,
  RemoteConfigParams.showBackgroundSplash: true,
  RemoteConfigParams.paladinsApiUnavailable: false,
  RemoteConfigParams.serverMaintenance: false,
  RemoteConfigParams.lowestSupportedVersion: "1.0.0",
};
