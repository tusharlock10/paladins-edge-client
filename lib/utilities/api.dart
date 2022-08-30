import "package:dio/dio.dart";
import "package:firebase_performance/firebase_performance.dart";
import "package:flutter/foundation.dart";
import "package:image_picker/image_picker.dart";
import "package:mime/mime.dart";
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
)..interceptors.add(_FirebasePerformanceLogger());

/// Upload an image to the provided S3 URL
Future<bool> uploadImage({
  required String url,
  required XFile image,
}) async {
  final fileName = image.name;
  final data = image.openRead();
  final imageLength = await image.length();
  final contentType = lookupMimeType(fileName);

  try {
    await Dio().put(
      url,
      data: data,
      options: Options(
        headers: {
          "Access-Control-Allow-Origin": "*",
          Headers.contentLengthHeader: imageLength,
          Headers.contentTypeHeader: contentType,
        },
      ),
    );

    return true;
  } catch (_) {
    return false;
  }
}

class _FirebasePerformanceLogger extends Interceptor {
  @override
  void onRequest(options, handler) {
    final httpMethod = _getHttpMethod(options.method);
    final metric = FirebasePerformance.instance
        .newHttpMetric(options.uri.toString(), httpMethod);
    metric.start();
    options.extra["metric"] = metric;
    handler.next(options);
  }

  @override
  void onResponse(response, handler) {
    final metric = response.requestOptions.extra["metric"] as HttpMetric;
    metric.httpResponseCode = response.statusCode;
    metric.responseContentType =
        response.headers.value(Headers.contentTypeHeader);
    metric.stop();

    final message =
        "${response.requestOptions.method} ${response.statusCode} ${response.realUri}";
    debugPrint(message);
    handler.next(response);
  }

  @override
  void onError(error, handler) {
    final metric = error.requestOptions.extra["metric"] as HttpMetric;
    metric.httpResponseCode = error.response?.statusCode;
    metric.responseContentType =
        error.response?.headers.value(Headers.contentTypeHeader);
    metric.stop();
    handler.next(error);
  }
}

HttpMethod _getHttpMethod(String method) {
  switch (method.toUpperCase()) {
    case "GET":
      return HttpMethod.Get;
    case "POST":
      return HttpMethod.Post;
    case "PATCH":
      return HttpMethod.Patch;
    case "PUT":
      return HttpMethod.Put;
    case "DELETE":
      return HttpMethod.Delete;
  }

  return HttpMethod.Options;
}
