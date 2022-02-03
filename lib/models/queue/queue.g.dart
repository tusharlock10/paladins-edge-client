// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Queue _$QueueFromJson(Map<String, dynamic> json) => Queue(
      queueId: json['queueId'] as String,
      name: json['name'] as String,
      activeMatchCount: json['activeMatchCount'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$QueueToJson(Queue instance) => <String, dynamic>{
      'queueId': instance.queueId,
      'name': instance.name,
      'activeMatchCount': instance.activeMatchCount,
      'createdAt': instance.createdAt.toIso8601String(),
    };
