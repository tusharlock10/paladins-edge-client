import "package:json_annotation/json_annotation.dart";

part "responses.g.dart";

@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> {
  final bool success;
  final String? error;
  final T data;

  ApiResponse({
    required this.success,
    required this.error,
    required this.data,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJson,
  ) {
    return _$ApiResponseFromJson(json, fromJson);
  }
  Map<String, dynamic> toJson(Object Function(T value) toJson) =>
      _$ApiResponseToJson(this, toJson);
}
