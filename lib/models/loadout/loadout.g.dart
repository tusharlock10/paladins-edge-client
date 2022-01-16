// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loadout.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoadoutCard _$LoadoutCardFromJson(Map<String, dynamic> json) => LoadoutCard(
      cardId2: json['cardId2'] as int,
      level: json['level'] as int,
    );

Map<String, dynamic> _$LoadoutCardToJson(LoadoutCard instance) =>
    <String, dynamic>{
      'cardId2': instance.cardId2,
      'level': instance.level,
    };

Loadout _$LoadoutFromJson(Map<String, dynamic> json) => Loadout(
      loadoutHash: json['loadoutHash'] as String,
      championId: json['championId'] as String,
      playerId: json['playerId'] as String,
      name: json['name'] as String,
      loadoutCards: (json['loadoutCards'] as List<dynamic>)
          .map((e) => LoadoutCard.fromJson(e as Map<String, dynamic>))
          .toList(),
      isImported: json['isImported'] as bool,
    );

Map<String, dynamic> _$LoadoutToJson(Loadout instance) => <String, dynamic>{
      'loadoutHash': instance.loadoutHash,
      'championId': instance.championId,
      'playerId': instance.playerId,
      'name': instance.name,
      'loadoutCards': instance.loadoutCards,
      'isImported': instance.isImported,
    };
