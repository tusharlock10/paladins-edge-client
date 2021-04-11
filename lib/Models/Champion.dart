import 'package:json_annotation/json_annotation.dart';
part 'Champion.g.dart';

@JsonSerializable()
class _Ability {
  final int abilityId; // Paladins ability id
  final String name; // name of the ability
  final String imageUrl; // Image of the ability
  final String damageType; // Area or Direct damage
  final int cooldown; // Recharge time of the ability in seconds
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

@JsonSerializable()
class _Talent {
  final int talentId; // Paladins talent id
  final String name; // name of the talent
  final String imageUrl; // Image of the talent
  final int cooldown; // Recharge time of the talent in seconds
  final String description; // _Talent description
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

@JsonSerializable()
class _Card {
  final int cardId; // Paladins card id
  final String name; // name of the card
  final String imageUrl; // Image of the card
  final int cooldown; // Recharge time of the card in seconds
  final String description; // card description
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

@JsonSerializable()
class Champion {
  final DateTime dateCreated;
  final int championId; // Paladins champion id
  final String name; // eg. Androxus
  final String iconUrl; // Icon of the champion
  final String headerUrl; // Header image of the champion
  final String splashUrl; // Splash image of the champion
  final String title; // eg. The Godslayer
  final String role; // eg. Flank

  final DateTime releaseDate;
  final int health; // eg. 2100
  final int movementSpeed; // eg. 370
  final int damageFallOffRange; // eg. 50 (units)
  final String? lore; // lore of that champion,

  final List<_Ability>? abilities; // List of all the abilities of th champion
  final List<_Talent>? talents; // List of all the talents of th champion
  final List<_Card>? cards; // List of all the cards of th champion

  final bool latestChampion; // Whether the champion is newly added in the game
  final bool
      onFreeWeeklyRotation; // Whether the champion is on weekly free rotation
  final bool
      onFreeRotation; // Whether the champion is on free rotation for some other causes

  Champion({
    required this.dateCreated,
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
