import "package:dio/dio.dart";
import "package:image_picker/image_picker.dart";
import "package:mime/mime.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/utilities/stopwatch.dart" show Stopwatch;

// api singleton
// authorization header is set by authProvider
final api = Dio(
  BaseOptions(
    baseUrl: constants.baseUrl,
    sendTimeout: const Duration(milliseconds: constants.apiTimeout),
    receiveTimeout: const Duration(milliseconds: constants.apiTimeout),
    connectTimeout: const Duration(milliseconds: constants.apiTimeout),
  ),
);

void initializeApi() {
  api.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        Stopwatch.startStopTimer("api-${options.path}");

        return handler.next(options);
      },
      onResponse: (response, handler) {
        Stopwatch.startStopTimer("api-${response.requestOptions.path}");

        return handler.next(response);
      },
      onError: (error, handler) {
        Stopwatch.startStopTimer("api-${error.requestOptions.path}");

        return handler.next(error);
      },
    ),
  );
}

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
