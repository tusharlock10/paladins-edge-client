import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../Constants.dart' show TypeIds;

part 'Champion.g.dart';

@HiveType(typeId: TypeIds.ChampionAbility)
@JsonSerializable()
class Ability {
  @HiveField(0)
  final int abilityId; // Paladins ability id
  @HiveField(1)
  final String name; // name of the ability
  @HiveField(2)
  final String imageUrl; // Image of the ability
  @HiveField(3)
  final String damageType; // Area or Direct damage
  @HiveField(4)
  final double cooldown; // Recharge time of the ability in seconds
  @HiveField(5)
  final String description; // Ability description

  Ability({
    required this.abilityId,
    required this.name,
    required this.imageUrl,
    required this.damageType,
    required this.cooldown,
    required this.description,
  });

  factory Ability.fromJson(Map<String, dynamic> json) =>
      _$AbilityFromJson(json);
  Map<String, dynamic> toJson() => _$AbilityToJson(this);
}

@HiveType(typeId: TypeIds.ChampionTalent)
@JsonSerializable()
class Talent {
  @HiveField(0)
  final int talentId; // Paladins talent id
  @HiveField(1)
  final String name; // name of the talent
  @HiveField(2)
  final String imageUrl; // Image of the talent
  @HiveField(3)
  final double cooldown; // Recharge time of the talent in seconds
  @HiveField(4)
  final String description; // Talent description
  @HiveField(5)
  final String
      modifier; // The ability that the talent modifies eg. Weapon/Reversal

  Talent({
    required this.talentId,
    required this.name,
    required this.imageUrl,
    required this.cooldown,
    required this.description,
    required this.modifier,
  });

  factory Talent.fromJson(Map<String, dynamic> json) => _$TalentFromJson(json);
  Map<String, dynamic> toJson() => _$TalentToJson(this);
}

@HiveType(typeId: TypeIds.ChampionCard)
@JsonSerializable()
class Card {
  @HiveField(0)
  final int cardId; // Paladins card id
  @HiveField(1)
  final String name; // name of the card
  @HiveField(2)
  final String imageUrl; // Image of the card
  @HiveField(3)
  final double cooldown; // Recharge time of the card in seconds
  @HiveField(4)
  final String description; // card description
  @HiveField(5)
  final String
      modifier; // The ability that the card modifies eg. Nether Step/Reversal

  Card({
    required this.cardId,
    required this.name,
    required this.imageUrl,
    required this.cooldown,
    required this.description,
    required this.modifier,
  });

  factory Card.fromJson(Map<String, dynamic> json) => _$CardFromJson(json);
  Map<String, dynamic> toJson() => _$CardToJson(this);
}

@HiveType(typeId: TypeIds.Champion_Tag)
@JsonSerializable()
class Tag {
  @HiveField(0)
  final String name; // name of the tag
  @HiveField(1)
  final String color; // color of tag in hex string

  Tag({
    required this.name,
    required this.color,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
  Map<String, dynamic> toJson() => _$TagToJson(this);
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
  final double health; // eg. 2100
  @HiveField(9)
  final double movementSpeed; // eg. 370
  @HiveField(10)
  final double damageFallOffRange; // eg. 50 (units)
  @HiveField(11)
  final double weaponDamage; // damage of the champion eg. 520
  @HiveField(12)
  final double fireRate; // fire rate of the champion in sec eg. 0.36
  @HiveField(13)
  final String? lore; // lore of that champion,

  @HiveField(14)
  final List<Ability>? abilities; // List of all the abilities of th champion
  @HiveField(15)
  final List<Talent>? talents; // List of all the talents of th champion
  @HiveField(16)
  final List<Card>? cards; // List of all the cards of th champion

  @HiveField(17)
  final bool latestChampion; // Whether the champion is newly added in the game
  @HiveField(18)
  final bool onFreeRotation; // Whether the champion is on free rotation
  @HiveField(19)
  final List<Tag> tags; // For showing extra champion info

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
    required this.weaponDamage,
    required this.fireRate,
    required this.lore,
    required this.abilities,
    required this.talents,
    required this.cards,
    required this.latestChampion,
    required this.onFreeRotation,
    required this.tags,
  });

  factory Champion.fromJson(Map<String, dynamic> json) =>
      _$ChampionFromJson(json);
  Map<String, dynamic> toJson() => _$ChampionToJson(this);
}
