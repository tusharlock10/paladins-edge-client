// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QueueDetailsResponse _$QueueDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    QueueDetailsResponse(
      queue: (json['queue'] as List<dynamic>)
          .map((e) => Queue.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QueueDetailsResponseToJson(
        QueueDetailsResponse instance) =>
    <String, dynamic>{
      'queue': instance.queue,
    };

QueueTimelineResponse _$QueueTimelineResponseFromJson(
        Map<String, dynamic> json) =>
    QueueTimelineResponse(
      timeline: (json['timeline'] as List<dynamic>)
          .map((e) => Queue.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QueueTimelineResponseToJson(
        QueueTimelineResponse instance) =>
    <String, dynamic>{
      'timeline': instance.timeline,
    };
