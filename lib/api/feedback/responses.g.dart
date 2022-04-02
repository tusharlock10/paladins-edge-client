// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadImageUrlResponse _$UploadImageUrlResponseFromJson(
        Map<String, dynamic> json) =>
    UploadImageUrlResponse(
      uploadUrl: json['uploadUrl'] as String,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$UploadImageUrlResponseToJson(
        UploadImageUrlResponse instance) =>
    <String, dynamic>{
      'uploadUrl': instance.uploadUrl,
      'imageUrl': instance.imageUrl,
    };

SubmitFeedbackResponse _$SubmitFeedbackResponseFromJson(
        Map<String, dynamic> json) =>
    SubmitFeedbackResponse(
      feedback: Feedback.fromJson(json['feedback'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubmitFeedbackResponseToJson(
        SubmitFeedbackResponse instance) =>
    <String, dynamic>{
      'feedback': instance.feedback,
    };
