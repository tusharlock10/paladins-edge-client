// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faq.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FAQ _$FAQFromJson(Map<String, dynamic> json) => FAQ(
      position: json['position'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );

Map<String, dynamic> _$FAQToJson(FAQ instance) => <String, dynamic>{
      'position': instance.position,
      'title': instance.title,
      'body': instance.body,
    };
