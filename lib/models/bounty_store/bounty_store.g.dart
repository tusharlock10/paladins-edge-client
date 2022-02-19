// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bounty_store.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BountyStoreAdapter extends TypeAdapter<BountyStore> {
  @override
  final int typeId = 13;

  @override
  BountyStore read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BountyStore(
      bountyStoreId: fields[0] as String,
      skinName: fields[1] as String,
      championId: fields[2] as int,
      championName: fields[3] as String,
      finalPrice: fields[4] as String,
      initialPrice: fields[5] as String,
      endDate: fields[6] as DateTime,
      type: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BountyStore obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.bountyStoreId)
      ..writeByte(1)
      ..write(obj.skinName)
      ..writeByte(2)
      ..write(obj.championId)
      ..writeByte(3)
      ..write(obj.championName)
      ..writeByte(4)
      ..write(obj.finalPrice)
      ..writeByte(5)
      ..write(obj.initialPrice)
      ..writeByte(6)
      ..write(obj.endDate)
      ..writeByte(7)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BountyStoreAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BountyStore _$BountyStoreFromJson(Map<String, dynamic> json) => BountyStore(
      bountyStoreId: json['bountyStoreId'] as String,
      skinName: json['skinName'] as String,
      championId: json['championId'] as int,
      championName: json['championName'] as String,
      finalPrice: json['finalPrice'] as String,
      initialPrice: json['initialPrice'] as String,
      endDate: DateTime.parse(json['endDate'] as String),
      type: json['type'] as String,
    );

Map<String, dynamic> _$BountyStoreToJson(BountyStore instance) =>
    <String, dynamic>{
      'bountyStoreId': instance.bountyStoreId,
      'skinName': instance.skinName,
      'championId': instance.championId,
      'championName': instance.championName,
      'finalPrice': instance.finalPrice,
      'initialPrice': instance.initialPrice,
      'endDate': instance.endDate.toIso8601String(),
      'type': instance.type,
    };
