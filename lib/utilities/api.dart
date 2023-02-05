import "package:dio/dio.dart";
import "package:paladinsedge/constants/index.dart" as constants;

// api singleton
// authorization header is set by authProvider
final api = Dio(
  BaseOptions(
    baseUrl: constants.Env.baseUrl,
    sendTimeout: constants.apiTimeout,
    receiveTimeout: constants.apiTimeout,
    connectTimeout: constants.apiTimeout,
  ),
);
