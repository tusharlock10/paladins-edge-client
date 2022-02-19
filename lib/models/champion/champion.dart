import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paladinsedge/constants.dart' show TypeIds;
import 'package:paladinsedge/utilities/index.dart' as utilities;

part 'champion.g.dart';

@HiveType(typeId: TypeIds.championAbility)
@JsonSerializable()
class Ability {
  /// Paladins ability id
  @HiveField(0)
  final int abilityId;

  /// name of the ability
  @HiveField(1)
  final String name;

  /// Image of the ability
  @HiveField(2)
  final String imageUrl;

  /// Area or Direct damage
  @HiveField(3)
  final String damageType;

  /// Recharge time of the ability in seconds
  @HiveField(4)
  final double cooldown;

  /// Ability description
  @HiveField(5)
  final String description;

  Ability({
    required this.abilityId,
    required this.name,
    required String imageUrl,
    required this.damageType,
    required this.cooldown,
    required this.description,
  }) : imageUrl = utilities.getUrlFromKey(imageUrl);

  factory Ability.fromJson(Map<String, dynamic> json) =>
      _$AbilityFromJson(json);
  Map<String, dynamic> toJson() => _$AbilityToJson(this);
}

@HiveType(typeId: TypeIds.championTalent)
@JsonSerializable()
class Talent {
  /// Paladins talent id
  @HiveField(0)
  final int talentId;

  /// Paladins talent id to link with the getItems api
  @HiveField(1)
  final int talentId2;

  /// name of the talent
  @HiveField(2)
  final String name;

  /// Image of the talent
  @HiveField(3)
  final String imageUrl;

  /// Recharge time of the talent in seconds
  @HiveField(4)
  final double cooldown;

  /// Talent description
  @HiveField(5)
  final String description;

  /// The ability that the talent modifies eg. Weapon/Reversal
  @HiveField(6)
  final String modifier;

  Talent({
    required this.talentId,
    required this.talentId2,
    required this.name,
    required String imageUrl,
    required this.cooldown,
    required this.description,
    required this.modifier,
  }) : imageUrl = utilities.getUrlFromKey(imageUrl);

  factory Talent.fromJson(Map<String, dynamic> json) => _$TalentFromJson(json);
  Map<String, dynamic> toJson() => _$TalentToJson(this);
}

@HiveType(typeId: TypeIds.championCard)
@JsonSerializable()
class Card {
  /// Paladins card id
  @HiveField(0)
  final int cardId;

  /// Paladins card id to link with the getItems api
  @HiveField(1)
  final int cardId2;

  /// name of the card
  @HiveField(2)
  final String name;

  /// Image of the card
  @HiveField(3)
  final String imageUrl;

  /// Recharge time of the card in seconds
  @HiveField(4)
  final double cooldown;

  /// card description
  @HiveField(5)
  final String description;

  /// The ability that the card modifies eg. Nether Step/Reversal
  @HiveField(6)
  final String modifier;

  Card({
    required this.cardId,
    required this.cardId2,
    required this.name,
    required String imageUrl,
    required this.cooldown,
    required this.description,
    required this.modifier,
  }) : imageUrl = utilities.getUrlFromKey(imageUrl);

  factory Card.fromJson(Map<String, dynamic> json) => _$CardFromJson(json);
  Map<String, dynamic> toJson() => _$CardToJson(this);
}

@HiveType(typeId: TypeIds.championTag)
@JsonSerializable()
class Tag {
  /// name of the tag
  @HiveField(0)
  final String name;

  /// color of tag in hex string
  @HiveField(1)
  final String color;

  Tag({
    required this.name,
    required this.color,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
  Map<String, dynamic> toJson() => _$TagToJson(this);
}

@HiveType(typeId: TypeIds.champion)
@JsonSerializable()
class Champion {
  /// Paladins champion id
  @HiveField(0)
  final int championId;

  /// eg. Androxus
  @HiveField(1)
  final String name;

  /// Icon of the champion
  @HiveField(2)
  final String iconUrl;

  /// Header image of the champion
  @HiveField(3)
  final String headerUrl;

  /// Splash image of the champion
  @HiveField(4)
  final String splashUrl;

  /// eg. The Godslayer
  @HiveField(5)
  final String title;

  /// eg. Flank
  @HiveField(6)
  final String role;

  /// release date of the champion
  @HiveField(7)
  final DateTime releaseDate;

  /// eg. 2100
  @HiveField(8)
  final double health;

  /// eg. 370
  @HiveField(9)
  final double movementSpeed;

  /// eg. 50 (units)
  @HiveField(10)
  final double damageFallOffRange;

  /// damage of the champion eg. 520
  @HiveField(11)
  final double weaponDamage;

  /// fire rate of the champion in sec eg. 0.36
  @HiveField(12)
  final double fireRate;

  /// lore of that champion,
  @HiveField(13)
  final String lore;

  /// List of all the abilities of th champion
  @HiveField(14)
  final List<Ability> abilities;

  /// List of all the talents of th champion
  @HiveField(15)
  final List<Talent> talents;

  /// List of all the cards of th champion
  @HiveField(16)
  final List<Card> cards;

  /// Whether the champion is newly added in the game
  @HiveField(17)
  final bool latestChampion;

  /// Whether the champion is on free rotation
  @HiveField(18)
  final bool onFreeRotation;

  /// For showing extra champion info
  @HiveField(19)
  final List<Tag> tags;

  Champion({
    required this.championId,
    required this.name,
    required String iconUrl,
    required String headerUrl,
    required String splashUrl,
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
  })  : iconUrl = utilities.getUrlFromKey(iconUrl),
        headerUrl = utilities.getUrlFromKey(headerUrl),
        splashUrl = utilities.getUrlFromKey(splashUrl);

  factory Champion.fromJson(Map<String, dynamic> json) =>
      _$ChampionFromJson(json);
  Map<String, dynamic> toJson() => _$ChampionToJson(this);
}
