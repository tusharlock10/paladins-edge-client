// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TopMatchAdapter extends TypeAdapter<TopMatch> {
  @override
  final int typeId = 17;

  @override
  TopMatch read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TopMatch(
      matchId: fields[0] as int,
      type: fields[1] as String,
      value: fields[2] as int,
      playerName: fields[3] as String,
      playerId: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TopMatch obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.matchId)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.value)
      ..writeByte(3)
      ..write(obj.playerName)
      ..writeByte(4)
      ..write(obj.playerId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TopMatchAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchPlayerStats _$MatchPlayerStatsFromJson(Map<String, dynamic> json) =>
    MatchPlayerStats(
      kills: json['kills'] as num,
      assists: json['assists'] as num,
      deaths: json['deaths'] as num,
      weaponDamageDealt: json['weaponDamageDealt'] as num,
      totalDamageDealt: json['totalDamageDealt'] as num,
      damageShielded: json['damageShielded'] as num,
      totalDamageTaken: json['totalDamageTaken'] as num,
      selfHealingDone: json['selfHealingDone'] as num,
      healingDone: json['healingDone'] as num,
      biggestKillStreak: json['biggestKillStreak'] as num,
      totalMultiKills: json['totalMultiKills'] as num,
      objectiveTime: json['objectiveTime'] as num,
      creditsEarned: json['creditsEarned'] as num,
    );

Map<String, dynamic> _$MatchPlayerStatsToJson(MatchPlayerStats instance) =>
    <String, dynamic>{
      'kills': instance.kills,
      'assists': instance.assists,
      'deaths': instance.deaths,
      'weaponDamageDealt': instance.weaponDamageDealt,
      'totalDamageDealt': instance.totalDamageDealt,
      'damageShielded': instance.damageShielded,
      'totalDamageTaken': instance.totalDamageTaken,
      'selfHealingDone': instance.selfHealingDone,
      'healingDone': instance.healingDone,
      'biggestKillStreak': instance.biggestKillStreak,
      'totalMultiKills': instance.totalMultiKills,
      'objectiveTime': instance.objectiveTime,
      'creditsEarned': instance.creditsEarned,
    };

MatchPlayerItem _$MatchPlayerItemFromJson(Map<String, dynamic> json) =>
    MatchPlayerItem(
      itemId: json['itemId'] as int,
      itemLevel: json['itemLevel'] as int,
    );

Map<String, dynamic> _$MatchPlayerItemToJson(MatchPlayerItem instance) =>
    <String, dynamic>{
      'itemId': instance.itemId,
      'itemLevel': instance.itemLevel,
    };

MatchPlayerChampionCard _$MatchPlayerChampionCardFromJson(
        Map<String, dynamic> json) =>
    MatchPlayerChampionCard(
      cardId2: json['cardId2'] as int,
      cardLevel: json['cardLevel'] as int,
    );

Map<String, dynamic> _$MatchPlayerChampionCardToJson(
        MatchPlayerChampionCard instance) =>
    <String, dynamic>{
      'cardId2': instance.cardId2,
      'cardLevel': instance.cardLevel,
    };

MatchPlayer _$MatchPlayerFromJson(Map<String, dynamic> json) => MatchPlayer(
      playerId: json['playerId'] as String,
      playerName: json['playerName'] as String,
      matchId: json['matchId'] as String,
      championId: json['championId'] as int,
      talentId2: json['talentId2'] as int,
      skin: json['skin'] as String,
      skinId: json['skinId'] as int,
      partyNumber: json['partyNumber'] as int?,
      team: json['team'] as int,
      matchPosition: json['matchPosition'] as int?,
      playerRanked: json['playerRanked'] == null
          ? null
          : Ranked.fromJson(json['playerRanked'] as Map<String, dynamic>),
      playerStats: MatchPlayerStats.fromJson(
          json['playerStats'] as Map<String, dynamic>),
      playerItems: (json['playerItems'] as List<dynamic>)
          .map((e) => MatchPlayerItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      playerChampionCards: (json['playerChampionCards'] as List<dynamic>)
          .map((e) =>
              MatchPlayerChampionCard.fromJson(e as Map<String, dynamic>))
          .toList(),
      isInComplete: json['isInComplete'] as bool,
    );

Map<String, dynamic> _$MatchPlayerToJson(MatchPlayer instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'playerName': instance.playerName,
      'matchId': instance.matchId,
      'championId': instance.championId,
      'talentId2': instance.talentId2,
      'skin': instance.skin,
      'skinId': instance.skinId,
      'partyNumber': instance.partyNumber,
      'team': instance.team,
      'matchPosition': instance.matchPosition,
      'playerRanked': instance.playerRanked,
      'playerStats': instance.playerStats,
      'playerItems': instance.playerItems,
      'playerChampionCards': instance.playerChampionCards,
      'isInComplete': instance.isInComplete,
    };

Match _$MatchFromJson(Map<String, dynamic> json) => Match(
      matchId: json['matchId'] as String,
      winningTeam: json['winningTeam'] as int,
      team1Score: json['team1Score'] as int,
      team2Score: json['team2Score'] as int,
      matchStartTime: DateTime.parse(json['matchStartTime'] as String),
      matchDuration: json['matchDuration'] as int,
      queue: json['queue'] as String,
      map: json['map'] as String,
      region: json['region'] as String,
      isRankedMatch: json['isRankedMatch'] as bool,
      championBans:
          (json['championBans'] as List<dynamic>).map((e) => e as int).toList(),
      isInComplete: json['isInComplete'] as bool,
    );

Map<String, dynamic> _$MatchToJson(Match instance) => <String, dynamic>{
      'matchId': instance.matchId,
      'winningTeam': instance.winningTeam,
      'team1Score': instance.team1Score,
      'team2Score': instance.team2Score,
      'matchStartTime': instance.matchStartTime.toIso8601String(),
      'matchDuration': instance.matchDuration,
      'queue': instance.queue,
      'map': instance.map,
      'region': instance.region,
      'isRankedMatch': instance.isRankedMatch,
      'championBans': instance.championBans,
      'isInComplete': instance.isInComplete,
    };

TopMatch _$TopMatchFromJson(Map<String, dynamic> json) => TopMatch(
      matchId: json['matchId'] as int,
      type: json['type'] as String,
      value: json['value'] as int,
      playerName: json['playerName'] as String,
      playerId: json['playerId'] as int,
    );

Map<String, dynamic> _$TopMatchToJson(TopMatch instance) => <String, dynamic>{
      'matchId': instance.matchId,
      'type': instance.type,
      'value': instance.value,
      'playerName': instance.playerName,
      'playerId': instance.playerId,
    };
