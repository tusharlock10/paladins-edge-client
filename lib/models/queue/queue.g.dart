// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QueueRegionAdapter extends TypeAdapter<QueueRegion> {
  @override
  final int typeId = 16;

  @override
  QueueRegion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QueueRegion(
      region: fields[0] as String,
      activeMatchCount: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, QueueRegion obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.region)
      ..writeByte(1)
      ..write(obj.activeMatchCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QueueRegionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
      queueRegions:
          fields[4] == null ? [] : (fields[4] as List).cast<QueueRegion>(),
    );
  }

  @override
  void write(BinaryWriter writer, Queue obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.queueId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.activeMatchCount)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.queueRegions);
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

QueueRegion _$QueueRegionFromJson(Map<String, dynamic> json) => QueueRegion(
      region: json['region'] as String,
      activeMatchCount: json['activeMatchCount'] as int,
    );

Map<String, dynamic> _$QueueRegionToJson(QueueRegion instance) =>
    <String, dynamic>{
      'region': instance.region,
      'activeMatchCount': instance.activeMatchCount,
    };

Queue _$QueueFromJson(Map<String, dynamic> json) => Queue(
      queueId: json['queueId'] as int,
      name: json['name'] as String,
      activeMatchCount: json['activeMatchCount'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      queueRegions: (json['queueRegions'] as List<dynamic>)
          .map((e) => QueueRegion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QueueToJson(Queue instance) => <String, dynamic>{
      'queueId': instance.queueId,
      'name': instance.name,
      'activeMatchCount': instance.activeMatchCount,
      'createdAt': instance.createdAt.toIso8601String(),
      'queueRegions': instance.queueRegions,
    };
