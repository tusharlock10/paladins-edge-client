import "package:json_annotation/json_annotation.dart";
import "package:paladinsedge/models/index.dart" show Feedback;

part "responses.g.dart";

@JsonSerializable()
class UploadImageUrlResponse {
  final String uploadUrl;
  final String imageUrl;

  UploadImageUrlResponse({
    required this.uploadUrl,
    required this.imageUrl,
  });

  factory UploadImageUrlResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadImageUrlResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UploadImageUrlResponseToJson(this);
}

@JsonSerializable()
class SubmitFeedbackResponse {
  final Feedback feedback;

  SubmitFeedbackResponse({required this.feedback});

  factory SubmitFeedbackResponse.fromJson(Map<String, dynamic> json) =>
      _$SubmitFeedbackResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SubmitFeedbackResponseToJson(this);
}
