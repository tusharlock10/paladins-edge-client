import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

const _timeout = 6 * 1000; // 10 seconds
const _baseUrl =
    kDebugMode ? "http://192.168.0.103:8000" : "http://192.168.0.103:8000";

final api = Dio(
  BaseOptions(
    baseUrl: _baseUrl,
    sendTimeout: _timeout,
    receiveTimeout: _timeout,
    connectTimeout: _timeout,
  ),
);
