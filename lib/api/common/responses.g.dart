// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EssentialsResponse _$EssentialsResponseFromJson(Map<String, dynamic> json) =>
    EssentialsResponse(
      success: json['success'] as bool? ?? false,
      error: json['error'] as String?,
      data: json['data'] == null
          ? null
          : Essentials.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EssentialsResponseToJson(EssentialsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'data': instance.data,
    };

BountyStoreResponse _$BountyStoreResponseFromJson(Map<String, dynamic> json) =>
    BountyStoreResponse(
      success: json['success'] as bool? ?? false,
      error: json['error'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => BountyStore.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BountyStoreResponseToJson(
        BountyStoreResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'data': instance.data,
    };

ItemsResponse _$ItemsResponseFromJson(Map<String, dynamic> json) =>
    ItemsResponse(
      success: json['success'] as bool? ?? false,
      error: json['error'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItemsResponseToJson(ItemsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'data': instance.data,
    };

FaqsResponse _$FaqsResponseFromJson(Map<String, dynamic> json) => FaqsResponse(
      success: json['success'] as bool? ?? false,
      error: json['error'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => FAQ.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FaqsResponseToJson(FaqsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'data': instance.data,
    };

SubmitFeedbackResponse _$SubmitFeedbackResponseFromJson(
        Map<String, dynamic> json) =>
    SubmitFeedbackResponse(
      success: json['success'] as bool? ?? false,
      error: json['error'] as String?,
      data: json['data'] == null
          ? null
          : Feedback.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubmitFeedbackResponseToJson(
        SubmitFeedbackResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'data': instance.data,
    };
