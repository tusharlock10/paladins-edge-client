import "package:paladinsedge/constants/constants.dart";

abstract class AppType {
  static const development = "development";
  static const production = "production";

  static const developmentShort = "dev";
  static const productionShort = "prod";

  static String get shortAppType =>
      isDebug ? developmentShort : productionShort;

  static String get appType => isDebug ? development : production;
}
