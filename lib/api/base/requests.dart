import "package:dio/dio.dart";
import "package:paladinsedge/utilities/index.dart" as utilities;

abstract class HttpMethod {
  static const get = "get";
  static const post = "post";
  static const put = "put";
  static const patch = "patch";
  static const delete = "delete";
}

class ApiRequestInput<T> {
  String url;
  String method;
  T Function(Map<String, dynamic>) fromJson;
  T defaultValue;
  Map<String, dynamic>? pathParams;
  Map<String, dynamic>? queryParams;
  dynamic payload;

  ApiRequestInput({
    required this.url,
    required this.method,
    required this.fromJson,
    required this.defaultValue,
    this.pathParams,
    this.queryParams,
    this.payload,
  });
}

abstract class ApiRequest {
  static Future<T> apiRequest<T>(ApiRequestInput<T> input) async {
    final Future<Response<Map<String, dynamic>>> responseFuture;
    final url = _getUrlFromPathParams(input);

    switch (input.method) {
      case HttpMethod.get:
        responseFuture = utilities.api.get<Map<String, dynamic>>(
          url,
          queryParameters: input.queryParams,
        );
        break;
      case HttpMethod.post:
        responseFuture = utilities.api.post<Map<String, dynamic>>(
          url,
          queryParameters: input.queryParams,
          data: input.payload,
        );
        break;
      case HttpMethod.put:
        responseFuture = utilities.api.put<Map<String, dynamic>>(
          url,
          queryParameters: input.queryParams,
          data: input.payload,
        );
        break;
      case HttpMethod.patch:
        responseFuture = utilities.api.patch<Map<String, dynamic>>(
          url,
          queryParameters: input.queryParams,
          data: input.payload,
        );
        break;
      case HttpMethod.delete:
        responseFuture = utilities.api.delete<Map<String, dynamic>>(
          url,
          queryParameters: input.queryParams,
          data: input.payload,
        );
        break;
      default:
        throw UnimplementedError();
    }

    // TODO: add error handling
    final response = await responseFuture;
    if (response.data != null) {
      return input.fromJson(response.data as Map<String, dynamic>);
    }

    return input.defaultValue;
  }

  static String _getUrlFromPathParams(ApiRequestInput input) {
    var url = input.url;
    if (input.pathParams == null) {
      return url;
    }
    final pathParams = input.pathParams!;

    for (final paramKey in pathParams.keys) {
      final value = pathParams[paramKey]!;
      url = url.replaceAll(":$paramKey", value.toString());
    }

    return url;
  }
}
