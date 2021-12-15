import 'package:dio/dio.dart';
import 'package:paladinsedge/constants.dart' as constants;

// api singleton
// authourization header is set by authProvider
final api = Dio(
  BaseOptions(
    baseUrl: constants.Env.baseUrl,
    sendTimeout: constants.apiTimeout,
    receiveTimeout: constants.apiTimeout,
    connectTimeout: constants.apiTimeout,
  ),
);
