// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_champion.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayerChampionAdapter extends TypeAdapter<PlayerChampion> {
  @override
  final int typeId = 9;

  @override
  PlayerChampion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayerChampion(
      playerId: fields[0] as int,
      championId: fields[1] as int,
      totalAssists: fields[2] as int,
      totalDeaths: fields[3] as int,
      totalCredits: fields[4] as int,
      totalKills: fields[5] as int,
      lastPlayed: fields[6] as DateTime,
      losses: fields[7] as int,
      wins: fields[8] as int,
      playTime: fields[9] as int,
      level: fields[10] as int,
      totalXP: fields[11] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PlayerChampion obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.playerId)
      ..writeByte(1)
      ..write(obj.championId)
      ..writeByte(2)
      ..write(obj.totalAssists)
      ..writeByte(3)
      ..write(obj.totalDeaths)
      ..writeByte(4)
      ..write(obj.totalCredits)
      ..writeByte(5)
      ..write(obj.totalKills)
      ..writeByte(6)
      ..write(obj.lastPlayed)
      ..writeByte(7)
      ..write(obj.losses)
      ..writeByte(8)
      ..write(obj.wins)
      ..writeByte(9)
      ..write(obj.playTime)
      ..writeByte(10)
      ..write(obj.level)
      ..writeByte(11)
      ..write(obj.totalXP);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerChampionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerChampion _$PlayerChampionFromJson(Map<String, dynamic> json) =>
    PlayerChampion(
      playerId: json['playerId'] as int,
      championId: json['championId'] as int,
      totalAssists: json['totalAssists'] as int,
      totalDeaths: json['totalDeaths'] as int,
      totalCredits: json['totalCredits'] as int,
      totalKills: json['totalKills'] as int,
      lastPlayed: DateTime.parse(json['lastPlayed'] as String),
      losses: json['losses'] as int,
      wins: json['wins'] as int,
      playTime: json['playTime'] as int,
      level: json['level'] as int,
      totalXP: json['totalXP'] as int,
    );

Map<String, dynamic> _$PlayerChampionToJson(PlayerChampion instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'championId': instance.championId,
      'totalAssists': instance.totalAssists,
      'totalDeaths': instance.totalDeaths,
      'totalCredits': instance.totalCredits,
      'totalKills': instance.totalKills,
      'lastPlayed': instance.lastPlayed.toIso8601String(),
      'losses': instance.losses,
      'wins': instance.wins,
      'playTime': instance.playTime,
      'level': instance.level,
      'totalXP': instance.totalXP,
    };
