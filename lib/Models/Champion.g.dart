// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Champion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Ability _$_AbilityFromJson(Map<String, dynamic> json) {
  return _Ability(
    abilityId: json['abilityId'] as int,
    name: json['name'] as String,
    imageUrl: json['imageUrl'] as String,
    damageType: json['damageType'] as String,
    cooldown: json['cooldown'] as int,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$_AbilityToJson(_Ability instance) => <String, dynamic>{
      'abilityId': instance.abilityId,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'damageType': instance.damageType,
      'cooldown': instance.cooldown,
      'description': instance.description,
    };

_Talent _$_TalentFromJson(Map<String, dynamic> json) {
  return _Talent(
    talentId: json['talentId'] as int,
    name: json['name'] as String,
    imageUrl: json['imageUrl'] as String,
    cooldown: json['cooldown'] as int,
    description: json['description'] as String,
    modifier: json['modifier'] as String,
  );
}

Map<String, dynamic> _$_TalentToJson(_Talent instance) => <String, dynamic>{
      'talentId': instance.talentId,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'cooldown': instance.cooldown,
      'description': instance.description,
      'modifier': instance.modifier,
    };

_Card _$_CardFromJson(Map<String, dynamic> json) {
  return _Card(
    cardId: json['cardId'] as int,
    name: json['name'] as String,
    imageUrl: json['imageUrl'] as String,
    cooldown: json['cooldown'] as int,
    description: json['description'] as String,
    modifier: json['modifier'] as String,
  );
}

Map<String, dynamic> _$_CardToJson(_Card instance) => <String, dynamic>{
      'cardId': instance.cardId,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'cooldown': instance.cooldown,
      'description': instance.description,
      'modifier': instance.modifier,
    };

Champion _$ChampionFromJson(Map<String, dynamic> json) {
  return Champion(
    dateCreated: DateTime.parse(json['dateCreated'] as String),
    championId: json['championId'] as int,
    name: json['name'] as String,
    iconUrl: json['iconUrl'] as String,
    headerUrl: json['headerUrl'] as String,
    splashUrl: json['splashUrl'] as String,
    title: json['title'] as String,
    role: json['role'] as String,
    releaseDate: DateTime.parse(json['releaseDate'] as String),
    health: json['health'] as int,
    movementSpeed: json['movementSpeed'] as int,
    damageFallOffRange: json['damageFallOffRange'] as int,
    lore: json['lore'] as String?,
    abilities: (json['abilities'] as List<dynamic>?)
        ?.map((e) => _Ability.fromJson(e as Map<String, dynamic>))
        .toList(),
    talents: (json['talents'] as List<dynamic>?)
        ?.map((e) => _Talent.fromJson(e as Map<String, dynamic>))
        .toList(),
    cards: (json['cards'] as List<dynamic>?)
        ?.map((e) => _Card.fromJson(e as Map<String, dynamic>))
        .toList(),
    latestChampion: json['latestChampion'] as bool,
    onFreeWeeklyRotation: json['onFreeWeeklyRotation'] as bool,
    onFreeRotation: json['onFreeRotation'] as bool,
  );
}

Map<String, dynamic> _$ChampionToJson(Champion instance) => <String, dynamic>{
      'dateCreated': instance.dateCreated.toIso8601String(),
      'championId': instance.championId,
      'name': instance.name,
      'iconUrl': instance.iconUrl,
      'headerUrl': instance.headerUrl,
      'splashUrl': instance.splashUrl,
      'title': instance.title,
      'role': instance.role,
      'releaseDate': instance.releaseDate.toIso8601String(),
      'health': instance.health,
      'movementSpeed': instance.movementSpeed,
      'damageFallOffRange': instance.damageFallOffRange,
      'lore': instance.lore,
      'abilities': instance.abilities,
      'talents': instance.talents,
      'cards': instance.cards,
      'latestChampion': instance.latestChampion,
      'onFreeWeeklyRotation': instance.onFreeWeeklyRotation,
      'onFreeRotation': instance.onFreeRotation,
    };
