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
      wins: fields[0] as int,
      looses: fields[1] as int,
      rank: fields[2] as int,
      points: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Ranked obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.wins)
      ..writeByte(1)
      ..write(obj.looses)
      ..writeByte(2)
      ..write(obj.rank)
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
      name: fields[2] as String,
      avatarUrl: fields[4] as String,
      avatarBlurHash: fields[5] as String?,
      totalXP: fields[6] as int,
      hoursPlayed: fields[7] as int,
      level: fields[8] as int,
      totalWins: fields[9] as int,
      totalLosses: fields[10] as int,
      platform: fields[11] as String,
      region: fields[12] as String,
      accountCreationDate: fields[13] as DateTime,
      lastLoginDate: fields[14] as DateTime,
      ranked: fields[15] as Ranked,
      userId: fields[1] as String?,
      title: fields[3] as String?,
      lastUpdatedFriends: fields[16] as DateTime?,
      lastUpdatedPlayer: fields[17] as DateTime?,
      lastUpdatedMatches: fields[18] as DateTime?,
      lastUpdatedChampions: fields[19] as DateTime?,
      lastUpdatedLoadouts: fields[20] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Player obj) {
    writer
      ..writeByte(21)
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
      ..write(obj.avatarBlurHash)
      ..writeByte(6)
      ..write(obj.totalXP)
      ..writeByte(7)
      ..write(obj.hoursPlayed)
      ..writeByte(8)
      ..write(obj.level)
      ..writeByte(9)
      ..write(obj.totalWins)
      ..writeByte(10)
      ..write(obj.totalLosses)
      ..writeByte(11)
      ..write(obj.platform)
      ..writeByte(12)
      ..write(obj.region)
      ..writeByte(13)
      ..write(obj.accountCreationDate)
      ..writeByte(14)
      ..write(obj.lastLoginDate)
      ..writeByte(15)
      ..write(obj.ranked)
      ..writeByte(16)
      ..write(obj.lastUpdatedFriends)
      ..writeByte(17)
      ..write(obj.lastUpdatedPlayer)
      ..writeByte(18)
      ..write(obj.lastUpdatedMatches)
      ..writeByte(19)
      ..write(obj.lastUpdatedChampions)
      ..writeByte(20)
      ..write(obj.lastUpdatedLoadouts);
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
      wins: json['wins'] as int,
      looses: json['looses'] as int,
      rank: json['rank'] as int,
      points: json['points'] as int?,
    );

Map<String, dynamic> _$RankedToJson(Ranked instance) => <String, dynamic>{
      'wins': instance.wins,
      'looses': instance.looses,
      'rank': instance.rank,
      'points': instance.points,
    };

Player _$PlayerFromJson(Map<String, dynamic> json) => Player(
      playerId: json['playerId'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatarUrl'] as String,
      avatarBlurHash: json['avatarBlurHash'] as String?,
      totalXP: json['totalXP'] as int,
      hoursPlayed: json['hoursPlayed'] as int,
      level: json['level'] as int,
      totalWins: json['totalWins'] as int,
      totalLosses: json['totalLosses'] as int,
      platform: json['platform'] as String,
      region: json['region'] as String,
      accountCreationDate:
          DateTime.parse(json['accountCreationDate'] as String),
      lastLoginDate: DateTime.parse(json['lastLoginDate'] as String),
      ranked: Ranked.fromJson(json['ranked'] as Map<String, dynamic>),
      userId: json['userId'] as String?,
      title: json['title'] as String?,
      lastUpdatedFriends: json['lastUpdatedFriends'] == null
          ? null
          : DateTime.parse(json['lastUpdatedFriends'] as String),
      lastUpdatedPlayer: json['lastUpdatedPlayer'] == null
          ? null
          : DateTime.parse(json['lastUpdatedPlayer'] as String),
      lastUpdatedMatches: json['lastUpdatedMatches'] == null
          ? null
          : DateTime.parse(json['lastUpdatedMatches'] as String),
      lastUpdatedChampions: json['lastUpdatedChampions'] == null
          ? null
          : DateTime.parse(json['lastUpdatedChampions'] as String),
      lastUpdatedLoadouts: json['lastUpdatedLoadouts'] == null
          ? null
          : DateTime.parse(json['lastUpdatedLoadouts'] as String),
    );

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'playerId': instance.playerId,
      'userId': instance.userId,
      'name': instance.name,
      'title': instance.title,
      'avatarUrl': instance.avatarUrl,
      'avatarBlurHash': instance.avatarBlurHash,
      'totalXP': instance.totalXP,
      'hoursPlayed': instance.hoursPlayed,
      'level': instance.level,
      'totalWins': instance.totalWins,
      'totalLosses': instance.totalLosses,
      'platform': instance.platform,
      'region': instance.region,
      'accountCreationDate': instance.accountCreationDate.toIso8601String(),
      'lastLoginDate': instance.lastLoginDate.toIso8601String(),
      'ranked': instance.ranked,
      'lastUpdatedFriends': instance.lastUpdatedFriends?.toIso8601String(),
      'lastUpdatedPlayer': instance.lastUpdatedPlayer?.toIso8601String(),
      'lastUpdatedMatches': instance.lastUpdatedMatches?.toIso8601String(),
      'lastUpdatedChampions': instance.lastUpdatedChampions?.toIso8601String(),
      'lastUpdatedLoadouts': instance.lastUpdatedLoadouts?.toIso8601String(),
    };

LowerSearchPlayer _$LowerSearchPlayerFromJson(Map<String, dynamic> json) =>
    LowerSearchPlayer(
      playerId: json['playerId'] as String,
      name: json['name'] as String,
      isPrivate: json['isPrivate'] as bool,
      platform: json['platform'] as String,
    );

Map<String, dynamic> _$LowerSearchPlayerToJson(LowerSearchPlayer instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'name': instance.name,
      'isPrivate': instance.isPrivate,
      'platform': instance.platform,
    };
