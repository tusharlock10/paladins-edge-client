import "package:flutter_dotenv/flutter_dotenv.dart";

abstract class Env {
  static String get appType => _getEnv("APP_TYPE");
  static String get baseUrl => _getEnv("BASE_URL");
  static String get saltString => _getEnv("SALT_STRING");
  static String get githubLink => _getEnv("GITHUB_LINK");

  static Future<List<String>> loadEnv() async {
    await dotenv.load(fileName: "paladins-edge.env");
    final List<String> missingEnvs = [];
    if (appType == "") missingEnvs.add("APP_TYPE");
    if (baseUrl == "") missingEnvs.add("BASE_URL");
    if (saltString == "") missingEnvs.add("SALT_STRING");
    if (githubLink == "") missingEnvs.add("GITHUB_LINK");

    return missingEnvs;
  }

  static String _getEnv(String envName) {
    return dotenv.env[envName] ?? "";
  }
}

abstract class AppType {
  static const development = "development";
  static const staging = "staging";
  static const production = "production";

  static const developmentShort = "dev";
  static const stagingShort = "stage";
  static const productionShort = "prod";

  static String get shortAppType {
    if (Env.appType == production) {
      return productionShort;
    }
    if (Env.appType == staging) {
      return stagingShort;
    }

    return developmentShort;
  }
}