import 'package:dio/dio.dart';
import 'package:dio_firebase_performance/dio_firebase_performance.dart';

import '../Constants.dart' as Constants;

final api = Dio(
  BaseOptions(
    baseUrl: Constants.BaseUrl,
    sendTimeout: Constants.ApiTimeout,
    receiveTimeout: Constants.ApiTimeout,
    connectTimeout: Constants.ApiTimeout,
  ),
)..interceptors.add(
    Constants.IsDebug ? DioFirebasePerformanceInterceptor() : InterceptorsWrapper());
