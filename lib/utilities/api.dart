import "package:dio/dio.dart";
import "package:image_picker/image_picker.dart";
import "package:mime/mime.dart";
import "package:paladinsedge/constants.dart" as constants;

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
