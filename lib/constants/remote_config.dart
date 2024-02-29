abstract class RemoteConfigParams {
  static const paladinsApiUnavailable = "paladinsApiUnavailable";
  static const serverMaintenance = "serverMaintenance";
  static const lowestSupportedVersion = "lowestSupportedVersion";
}

final remoteConfigDefaults = {
  RemoteConfigParams.paladinsApiUnavailable: false,
  RemoteConfigParams.serverMaintenance: false,
  RemoteConfigParams.lowestSupportedVersion: "1.0.0",
};
