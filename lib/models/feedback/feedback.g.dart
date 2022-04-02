// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Feedback _$FeedbackFromJson(Map<String, dynamic> json) => Feedback(
      description: json['description'] as String,
      type: json['type'] as String,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$FeedbackToJson(Feedback instance) => <String, dynamic>{
      'description': instance.description,
      'type': instance.type,
      'imageUrl': instance.imageUrl,
    };
