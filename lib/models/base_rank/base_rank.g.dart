// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_rank.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BaseRankAdapter extends TypeAdapter<BaseRank> {
  @override
  final int typeId = 18;

  @override
  BaseRank read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BaseRank(
      rank: fields[0] as int,
      rankName: fields[1] as String,
      rankIconUrl: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BaseRank obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.rank)
      ..writeByte(1)
      ..write(obj.rankName)
      ..writeByte(2)
      ..write(obj.rankIconUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BaseRankAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseRank _$BaseRankFromJson(Map<String, dynamic> json) => BaseRank(
      rank: json['rank'] as int,
      rankName: json['rankName'] as String,
      rankIconUrl: json['rankIconUrl'] as String,
    );

Map<String, dynamic> _$BaseRankToJson(BaseRank instance) => <String, dynamic>{
      'rank': instance.rank,
      'rankName': instance.rankName,
      'rankIconUrl': instance.rankIconUrl,
    };
