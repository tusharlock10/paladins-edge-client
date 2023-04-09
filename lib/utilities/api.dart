import "package:dio/dio.dart";
import "package:paladinsedge/constants/index.dart" as constants;

// api singleton
// authorization header is set by authProvider
final api = Dio(
  BaseOptions(
    baseUrl: constants.Env.baseUrl,
    sendTimeout: const Duration(milliseconds: constants.apiTimeout),
    receiveTimeout: const Duration(milliseconds: constants.apiTimeout),
    connectTimeout: const Duration(milliseconds: constants.apiTimeout),
  ),
);
