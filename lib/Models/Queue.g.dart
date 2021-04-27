// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Queue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Queue _$QueueFromJson(Map<String, dynamic> json) {
  return Queue(
    id: json['_id'] as String,
    name: json['name'] as String,
    queueId: json['queueId'] as int,
    activeMatchCount: json['activeMatchCount'] as int,
  );
}

Map<String, dynamic> _$QueueToJson(Queue instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'queueId': instance.queueId,
      'activeMatchCount': instance.activeMatchCount,
    };
