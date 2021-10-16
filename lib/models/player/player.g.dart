// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RankedAdapter extends TypeAdapter<Ranked> {
  @override
  final int typeId = 5;

  @override
  Ranked read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Ranked(
      wins: fields[0] as int?,
      looses: fields[1] as int?,
      rank: fields[2] as int?,
      rankName: fields[3] as String?,
      rankIconUrl: fields[4] as String?,
      points: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Ranked obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.wins)
      ..writeByte(1)
      ..write(obj.looses)
      ..writeByte(2)
      ..write(obj.rank)
      ..writeByte(3)
      ..write(obj.rankName)
      ..writeByte(4)
      ..write(obj.rankIconUrl)
      ..writeByte(5)
      ..write(obj.points);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RankedAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PlayerAdapter extends TypeAdapter<Player> {
  @override
  final int typeId = 4;

  @override
  Player read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Player(
      playerId: fields[0] as String,
      userId: fields[1] as String?,
      name: fields[2] as String,
      title: fields[3] as String?,
      avatarUrl: fields[4] as String?,
      totalXP: fields[5] as int?,
      hoursPlayed: fields[6] as int?,
      level: fields[7] as int?,
      totalWins: fields[8] as int?,
      totalLosses: fields[9] as int?,
      platform: fields[10] as String?,
      region: fields[11] as String?,
      accountCreationDate: fields[12] as DateTime?,
      lastLoginDate: fields[13] as DateTime?,
      ranked: fields[14] as Ranked,
      status: fields[15] as String?,
      friends: (fields[16] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Player obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.playerId)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.avatarUrl)
      ..writeByte(5)
      ..write(obj.totalXP)
      ..writeByte(6)
      ..write(obj.hoursPlayed)
      ..writeByte(7)
      ..write(obj.level)
      ..writeByte(8)
      ..write(obj.totalWins)
      ..writeByte(9)
      ..write(obj.totalLosses)
      ..writeByte(10)
      ..write(obj.platform)
      ..writeByte(11)
      ..write(obj.region)
      ..writeByte(12)
      ..write(obj.accountCreationDate)
      ..writeByte(13)
      ..write(obj.lastLoginDate)
      ..writeByte(14)
      ..write(obj.ranked)
      ..writeByte(15)
      ..write(obj.status)
      ..writeByte(16)
      ..write(obj.friends);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ranked _$RankedFromJson(Map<String, dynamic> json) => Ranked(
      wins: json['wins'] as int?,
      looses: json['looses'] as int?,
      rank: json['rank'] as int?,
      rankName: json['rankName'] as String?,
      rankIconUrl: json['rankIconUrl'] as String?,
      points: json['points'] as int?,
    );

Map<String, dynamic> _$RankedToJson(Ranked instance) => <String, dynamic>{
      'wins': instance.wins,
      'looses': instance.looses,
      'rank': instance.rank,
      'rankName': instance.rankName,
      'rankIconUrl': instance.rankIconUrl,
      'points': instance.points,
    };

Player _$PlayerFromJson(Map<String, dynamic> json) => Player(
      playerId: json['playerId'] as String,
      userId: json['userId'] as String?,
      name: json['name'] as String,
      title: json['title'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      totalXP: json['totalXP'] as int?,
      hoursPlayed: json['hoursPlayed'] as int?,
      level: json['level'] as int?,
      totalWins: json['totalWins'] as int?,
      totalLosses: json['totalLosses'] as int?,
      platform: json['platform'] as String?,
      region: json['region'] as String?,
      accountCreationDate: json['accountCreationDate'] == null
          ? null
          : DateTime.parse(json['accountCreationDate'] as String),
      lastLoginDate: json['lastLoginDate'] == null
          ? null
          : DateTime.parse(json['lastLoginDate'] as String),
      ranked: Ranked.fromJson(json['ranked'] as Map<String, dynamic>),
      status: json['status'] as String?,
      friends:
          (json['friends'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'playerId': instance.playerId,
      'userId': instance.userId,
      'name': instance.name,
      'title': instance.title,
      'avatarUrl': instance.avatarUrl,
      'totalXP': instance.totalXP,
      'hoursPlayed': instance.hoursPlayed,
      'level': instance.level,
      'totalWins': instance.totalWins,
      'totalLosses': instance.totalLosses,
      'platform': instance.platform,
      'region': instance.region,
      'accountCreationDate': instance.accountCreationDate?.toIso8601String(),
      'lastLoginDate': instance.lastLoginDate?.toIso8601String(),
      'ranked': instance.ranked,
      'status': instance.status,
      'friends': instance.friends,
    };
