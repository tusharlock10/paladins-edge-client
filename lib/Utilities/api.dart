import 'package:dio/dio.dart';
import '../Constants.dart' as Constants;

final api = Dio(
  BaseOptions(
    baseUrl: Constants.BaseUrl,
    sendTimeout: Constants.ApiTimeout,
    receiveTimeout: Constants.ApiTimeout,
    connectTimeout: Constants.ApiTimeout,
  ),
);
