import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

import '../Constants.dart' show TypeIds;

part 'Champion.g.dart';

@HiveType(typeId: TypeIds.Champion_Ability)
@JsonSerializable()
class _Ability {
  @HiveField(0)
  final int abilityId; // Paladins ability id
  @HiveField(1)
  final String name; // name of the ability
  @HiveField(2)
  final String imageUrl; // Image of the ability
  @HiveField(3)
  final String damageType; // Area or Direct damage
  @HiveField(4)
  final int cooldown; // Recharge time of the ability in seconds
  @HiveField(5)
  final String description; // _Ability description

  _Ability({
    required this.abilityId,
    required this.name,
    required this.imageUrl,
    required this.damageType,
    required this.cooldown,
    required this.description,
  });

  factory _Ability.fromJson(Map<String, dynamic> json) =>
      _$_AbilityFromJson(json);
  Map<String, dynamic> toJson() => _$_AbilityToJson(this);
}

@HiveType(typeId: TypeIds.Champion_Talent)
@JsonSerializable()
class _Talent {
  @HiveField(0)
  final int talentId; // Paladins talent id
  @HiveField(1)
  final String name; // name of the talent
  @HiveField(2)
  final String imageUrl; // Image of the talent
  @HiveField(3)
  final int cooldown; // Recharge time of the talent in seconds
  @HiveField(4)
  final String description; // _Talent description
  @HiveField(5)
  final String
      modifier; // The ability that the talent modifies eg. Weapon/Reversal

  _Talent({
    required this.talentId,
    required this.name,
    required this.imageUrl,
    required this.cooldown,
    required this.description,
    required this.modifier,
  });

  factory _Talent.fromJson(Map<String, dynamic> json) =>
      _$_TalentFromJson(json);
  Map<String, dynamic> toJson() => _$_TalentToJson(this);
}

@HiveType(typeId: TypeIds.Champion_Card)
@JsonSerializable()
class _Card {
  @HiveField(0)
  final int cardId; // Paladins card id
  @HiveField(1)
  final String name; // name of the card
  @HiveField(2)
  final String imageUrl; // Image of the card
  @HiveField(3)
  final int cooldown; // Recharge time of the card in seconds
  @HiveField(4)
  final String description; // card description
  @HiveField(5)
  final String
      modifier; // The ability that the card modifies eg. Nether Step/Reversal

  _Card({
    required this.cardId,
    required this.name,
    required this.imageUrl,
    required this.cooldown,
    required this.description,
    required this.modifier,
  });

  factory _Card.fromJson(Map<String, dynamic> json) => _$_CardFromJson(json);
  Map<String, dynamic> toJson() => _$_CardToJson(this);
}

@HiveType(typeId: TypeIds.Champion)
@JsonSerializable()
class Champion {
  @HiveField(0)
  final String championId; // Paladins champion id
  @HiveField(1)
  final String name; // eg. Androxus
  @HiveField(2)
  final String iconUrl; // Icon of the champion
  @HiveField(3)
  final String headerUrl; // Header image of the champion
  @HiveField(4)
  final String splashUrl; // Splash image of the champion
  @HiveField(5)
  final String title; // eg. The Godslayer
  @HiveField(6)
  final String role; // eg. Flank

  @HiveField(7)
  final DateTime releaseDate;
  @HiveField(8)
  final int health; // eg. 2100
  @HiveField(9)
  final int movementSpeed; // eg. 370
  @HiveField(10)
  final int damageFallOffRange; // eg. 50 (units)
  @HiveField(11)
  final String? lore; // lore of that champion,

  @HiveField(12)
  final List<_Ability>? abilities; // List of all the abilities of th champion
  @HiveField(13)
  final List<_Talent>? talents; // List of all the talents of th champion
  @HiveField(14)
  final List<_Card>? cards; // List of all the cards of th champion

  @HiveField(15)
  final bool latestChampion; // Whether the champion is newly added in the game
  @HiveField(16)
  final bool
      onFreeWeeklyRotation; // Whether the champion is on weekly free rotation
  @HiveField(17)
  final bool
      onFreeRotation; // Whether the champion is on free rotation for some other causes

  Champion({
    required this.championId,
    required this.name,
    required this.iconUrl,
    required this.headerUrl,
    required this.splashUrl,
    required this.title,
    required this.role,
    required this.releaseDate,
    required this.health,
    required this.movementSpeed,
    required this.damageFallOffRange,
    required this.lore,
    required this.abilities,
    required this.talents,
    required this.cards,
    required this.latestChampion,
    required this.onFreeWeeklyRotation,
    required this.onFreeRotation,
  });

  factory Champion.fromJson(Map<String, dynamic> json) =>
      _$ChampionFromJson(json);
  Map<String, dynamic> toJson() => _$ChampionToJson(this);
}
