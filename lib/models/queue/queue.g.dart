// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QueueAdapter extends TypeAdapter<Queue> {
  @override
  final int typeId = 14;

  @override
  Queue read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Queue(
      queueId: fields[0] as int,
      name: fields[1] as String,
      activeMatchCount: fields[2] as int,
      createdAt: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Queue obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.queueId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.activeMatchCount)
      ..writeByte(3)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QueueAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Queue _$QueueFromJson(Map<String, dynamic> json) => Queue(
      queueId: json['queueId'] as int,
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
