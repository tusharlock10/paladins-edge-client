// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchPlayerStats _$MatchPlayerStatsFromJson(Map<String, dynamic> json) =>
    MatchPlayerStats(
      kills: json['kills'] as int,
      assists: json['assists'] as int,
      deaths: json['deaths'] as int,
      weaponDamageDealt: json['weaponDamageDealt'] as int,
      totalDamageDealt: json['totalDamageDealt'] as int,
      damageShielded: json['damageShielded'] as int,
      totalDamageTaken: json['totalDamageTaken'] as int,
      selfHealingDone: json['selfHealingDone'] as int,
      healingDone: json['healingDone'] as int,
      biggestKillStreak: json['biggestKillStreak'] as int,
      doubleKills: json['doubleKills'] as int,
      tripleKills: json['tripleKills'] as int,
      quadraKills: json['quadraKills'] as int,
      pentaKills: json['pentaKills'] as int,
      totalMultiKills: json['totalMultiKills'] as int,
      objectiveTime: json['objectiveTime'] as int,
      creditsEarnedfinal: json['creditsEarnedfinal'] as int,
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
      'doubleKills': instance.doubleKills,
      'tripleKills': instance.tripleKills,
      'quadraKills': instance.quadraKills,
      'pentaKills': instance.pentaKills,
      'totalMultiKills': instance.totalMultiKills,
      'objectiveTime': instance.objectiveTime,
      'creditsEarnedfinal': instance.creditsEarnedfinal,
    };

MatchPlayerItems _$MatchPlayerItemsFromJson(Map<String, dynamic> json) =>
    MatchPlayerItems(
      itemId: json['itemId'] as int,
      itemLevel: json['itemLevel'] as int,
    );

Map<String, dynamic> _$MatchPlayerItemsToJson(MatchPlayerItems instance) =>
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
      matchId: json['matchId'] as String,
      championId: json['championId'] as int,
      talentId2: json['talentId2'] as int,
      skin: json['skin'] as String,
      skinId: json['skinId'] as int,
      partyId: json['partyId'] as int,
      team: json['team'] as int,
      playerStats: MatchPlayerStats.fromJson(
          json['playerStats'] as Map<String, dynamic>),
      playerItems: (json['playerItems'] as List<dynamic>)
          .map((e) => MatchPlayerItems.fromJson(e as Map<String, dynamic>))
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
      'matchId': instance.matchId,
      'championId': instance.championId,
      'talentId2': instance.talentId2,
      'skin': instance.skin,
      'skinId': instance.skinId,
      'partyId': instance.partyId,
      'team': instance.team,
      'playerStats': instance.playerStats,
      'playerItems': instance.playerItems,
      'playerChampionCards': instance.playerChampionCards,
      'isInComplete': instance.isInComplete,
    };

Match _$MatchFromJson(Map<String, dynamic> json) => Match(
      matchId: json['matchId'] as String,
      playerIds:
          (json['playerIds'] as List<dynamic>).map((e) => e as String).toList(),
      winningTeam: json['winningTeam'] as int,
      team1Score: json['team1Score'] as int,
      team2Score: json['team2Score'] as int,
      matchStartTime: DateTime.parse(json['matchStartTime'] as String),
      matchDuration: json['matchDuration'] as int,
      queue: json['queue'] as String,
      map: json['map'] as String,
      region: json['region'] as String,
      championBans:
          (json['championBans'] as List<dynamic>).map((e) => e as int).toList(),
      isInComplete: json['isInComplete'] as bool,
    );

Map<String, dynamic> _$MatchToJson(Match instance) => <String, dynamic>{
      'matchId': instance.matchId,
      'playerIds': instance.playerIds,
      'winningTeam': instance.winningTeam,
      'team1Score': instance.team1Score,
      'team2Score': instance.team2Score,
      'matchStartTime': instance.matchStartTime.toIso8601String(),
      'matchDuration': instance.matchDuration,
      'queue': instance.queue,
      'map': instance.map,
      'region': instance.region,
      'championBans': instance.championBans,
      'isInComplete': instance.isInComplete,
    };