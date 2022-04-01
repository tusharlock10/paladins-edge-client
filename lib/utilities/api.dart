import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mime/mime.dart';
import 'package:paladinsedge/constants.dart' as constants;

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

/// Upload a file to the provided URL
Future<void> uploadFile({
  required String url,
  required String filePath,
}) async {
  final file = File(filePath);
  final contentType = lookupMimeType(filePath);

  await Dio().put(
    url,
    data: file.openRead(),
    options: Options(
      headers: {
        Headers.contentLengthHeader: file.lengthSync(),
        Headers.contentTypeHeader: contentType,
      },
    ),
  );
}
