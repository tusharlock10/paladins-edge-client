import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

const _baseUrl =
    kDebugMode ? "http://192.168.0.103:8000" : "http://192.168.0.103:8000";

final api = Dio(BaseOptions(baseUrl: _baseUrl));
