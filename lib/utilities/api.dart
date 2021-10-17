import 'package:dio/dio.dart';
import 'package:dio_firebase_performance/dio_firebase_performance.dart';
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
)..interceptors.add(
    constants.isDebug
        ? DioFirebasePerformanceInterceptor()
        : InterceptorsWrapper(),
  );
