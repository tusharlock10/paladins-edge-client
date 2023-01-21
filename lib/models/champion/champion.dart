import "package:hive/hive.dart";
import "package:json_annotation/json_annotation.dart";
import "package:paladinsedge/constants/index.dart" show TypeIds;
import "package:paladinsedge/utilities/index.dart" as utilities;

part "champion.g.dart";

@HiveType(typeId: TypeIds.championAbility)
@JsonSerializable()
class ChampionAbility {
  /// Paladins ability id
  @HiveField(0)
  final int abilityId;

  /// name of the ability
  @HiveField(1)
  final String name;

  /// Image of the ability
  @HiveField(2)
  final String imageUrl;

  ///blur hash or the ability image
  @HiveField(3)
  final String? imageBlurHash;

  /// Area or Direct damage
  @HiveField(4)
  final String damageType;

  /// Recharge time of the ability in seconds
  @HiveField(5)
  final double cooldown;

  /// Ability description
  @HiveField(6)
  final String description;

  ChampionAbility({
    required this.abilityId,
    required this.name,
    required String imageUrl,
    required this.imageBlurHash,
    required this.damageType,
    required this.cooldown,
    required this.description,
  }) : imageUrl = utilities.getUrlFromKey(imageUrl);

  factory ChampionAbility.fromJson(Map<String, dynamic> json) =>
      _$ChampionAbilityFromJson(json);
  Map<String, dynamic> toJson() => _$ChampionAbilityToJson(this);
}

@HiveType(typeId: TypeIds.championTalent)
@JsonSerializable()
class ChampionTalent {
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

  /// The level at which this talent unlocks
  @HiveField(7)
  final int? unlockLevel;

  ChampionTalent({
    required this.talentId,
    required this.talentId2,
    required this.name,
    required String imageUrl,
    required this.cooldown,
    required this.description,
    required this.modifier,
    this.unlockLevel,
  }) : imageUrl = utilities.getUrlFromKey(imageUrl);

  factory ChampionTalent.fromJson(Map<String, dynamic> json) =>
      _$ChampionTalentFromJson(json);
  Map<String, dynamic> toJson() => _$ChampionTalentToJson(this);
}

@HiveType(typeId: TypeIds.championCard)
@JsonSerializable()
class ChampionCard {
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

  /// blur hash of the card image
  @HiveField(4)
  final String? imageBlurHash;

  /// Recharge time of the card in seconds
  @HiveField(5)
  final double cooldown;

  /// card description
  @HiveField(6)
  final String description;

  /// The ability that the card modifies eg. Nether Step/Reversal
  @HiveField(7)
  final String modifier;

  ChampionCard({
    required this.cardId,
    required this.cardId2,
    required this.name,
    required String imageUrl,
    required this.imageBlurHash,
    required this.cooldown,
    required this.description,
    required this.modifier,
  }) : imageUrl = utilities.getUrlFromKey(imageUrl);

  factory ChampionCard.fromJson(Map<String, dynamic> json) =>
      _$ChampionCardFromJson(json);
  Map<String, dynamic> toJson() => _$ChampionCardToJson(this);
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

  /// blur hash of the icon
  @HiveField(3)
  final String? iconBlurHash;

  /// Header image of the champion
  @HiveField(4)
  final String headerUrl;

  /// Splash image of the champion
  @HiveField(5)
  final String splashUrl;

  /// blur hash of the splash image
  @HiveField(6)
  final String? splashBlurHash;

  /// eg. The Godslayer
  @HiveField(7)
  final String title;

  /// eg. Flank
  @HiveField(8)
  final String role;

  /// release date of the champion
  @HiveField(9)
  final DateTime releaseDate;

  /// eg. 2100
  @HiveField(10)
  final double health;

  /// eg. 370
  @HiveField(11)
  final double movementSpeed;

  /// eg. 50 (units)
  @HiveField(12)
  final double damageFallOffRange;

  /// damage of the champion eg. 520
  @HiveField(13)
  final double weaponDamage;

  /// fire rate of the champion in sec eg. 0.36
  @HiveField(14)
  final double fireRate;

  /// lore of that champion,
  @HiveField(15)
  final String lore;

  /// List of all the abilities of th champion
  @HiveField(16)
  final List<ChampionAbility> abilities;

  /// List of all the talents of th champion
  @HiveField(17)
  final List<ChampionTalent> talents;

  /// List of all the cards of th champion
  @HiveField(18)
  final List<ChampionCard> cards;

  /// Whether the champion is newly added in the game
  @HiveField(19)
  final bool latestChampion;

  /// Whether the champion is on free rotation
  @HiveField(20)
  final bool onFreeRotation;

  /// cost to unlock the champion in game
  @HiveField(22)
  final int? unlockCost;

  Champion({
    required this.championId,
    required this.name,
    required String iconUrl,
    required this.iconBlurHash,
    required String headerUrl,
    required String splashUrl,
    required this.splashBlurHash,
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
    this.unlockCost,
  })  : iconUrl = utilities.getUrlFromKey(iconUrl),
        headerUrl = utilities.getUrlFromKey(headerUrl),
        splashUrl = utilities.getUrlFromKey(splashUrl);

  factory Champion.fromJson(Map<String, dynamic> json) =>
      _$ChampionFromJson(json);
  Map<String, dynamic> toJson() => _$ChampionToJson(this);
}
