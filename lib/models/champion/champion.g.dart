// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'champion.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChampionAbilityAdapter extends TypeAdapter<ChampionAbility> {
  @override
  final int typeId = 1;

  @override
  ChampionAbility read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChampionAbility(
      abilityId: fields[0] as int,
      name: fields[1] as String,
      imageUrl: fields[2] as String,
      imageBlurHash: fields[3] as String?,
      damageType: fields[4] as String,
      cooldown: fields[5] as double,
      description: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ChampionAbility obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.abilityId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.imageUrl)
      ..writeByte(3)
      ..write(obj.imageBlurHash)
      ..writeByte(4)
      ..write(obj.damageType)
      ..writeByte(5)
      ..write(obj.cooldown)
      ..writeByte(6)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChampionAbilityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ChampionTalentAdapter extends TypeAdapter<ChampionTalent> {
  @override
  final int typeId = 2;

  @override
  ChampionTalent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChampionTalent(
      talentId: fields[0] as int,
      talentId2: fields[1] as int,
      name: fields[2] as String,
      imageUrl: fields[3] as String,
      cooldown: fields[4] as double,
      description: fields[5] as String,
      modifier: fields[6] as String,
      unlockLevel: fields[7] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ChampionTalent obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.talentId)
      ..writeByte(1)
      ..write(obj.talentId2)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.imageUrl)
      ..writeByte(4)
      ..write(obj.cooldown)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.modifier)
      ..writeByte(7)
      ..write(obj.unlockLevel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChampionTalentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ChampionCardAdapter extends TypeAdapter<ChampionCard> {
  @override
  final int typeId = 3;

  @override
  ChampionCard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChampionCard(
      cardId: fields[0] as int,
      cardId2: fields[1] as int,
      name: fields[2] as String,
      imageUrl: fields[3] as String,
      imageBlurHash: fields[4] as String?,
      cooldown: fields[5] as double,
      description: fields[6] as String,
      modifier: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ChampionCard obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.cardId)
      ..writeByte(1)
      ..write(obj.cardId2)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.imageUrl)
      ..writeByte(4)
      ..write(obj.imageBlurHash)
      ..writeByte(5)
      ..write(obj.cooldown)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.modifier);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChampionCardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TagAdapter extends TypeAdapter<Tag> {
  @override
  final int typeId = 8;

  @override
  Tag read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Tag(
      name: fields[0] as String,
      color: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Tag obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TagAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ChampionAdapter extends TypeAdapter<Champion> {
  @override
  final int typeId = 0;

  @override
  Champion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Champion(
      championId: fields[0] as int,
      name: fields[1] as String,
      iconUrl: fields[2] as String,
      iconBlurHash: fields[3] as String?,
      headerUrl: fields[4] as String,
      splashUrl: fields[5] as String,
      splashBlurHash: fields[6] as String?,
      title: fields[7] as String,
      role: fields[8] as String,
      releaseDate: fields[9] as DateTime,
      health: fields[10] as double,
      movementSpeed: fields[11] as double,
      damageFallOffRange: fields[12] as double,
      weaponDamage: fields[13] as double,
      fireRate: fields[14] as double,
      lore: fields[15] as String,
      abilities: (fields[16] as List).cast<ChampionAbility>(),
      talents: (fields[17] as List).cast<ChampionTalent>(),
      cards: (fields[18] as List).cast<ChampionCard>(),
      latestChampion: fields[19] as bool,
      onFreeRotation: fields[20] as bool,
      unlockCost: fields[22] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Champion obj) {
    writer
      ..writeByte(22)
      ..writeByte(0)
      ..write(obj.championId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.iconUrl)
      ..writeByte(3)
      ..write(obj.iconBlurHash)
      ..writeByte(4)
      ..write(obj.headerUrl)
      ..writeByte(5)
      ..write(obj.splashUrl)
      ..writeByte(6)
      ..write(obj.splashBlurHash)
      ..writeByte(7)
      ..write(obj.title)
      ..writeByte(8)
      ..write(obj.role)
      ..writeByte(9)
      ..write(obj.releaseDate)
      ..writeByte(10)
      ..write(obj.health)
      ..writeByte(11)
      ..write(obj.movementSpeed)
      ..writeByte(12)
      ..write(obj.damageFallOffRange)
      ..writeByte(13)
      ..write(obj.weaponDamage)
      ..writeByte(14)
      ..write(obj.fireRate)
      ..writeByte(15)
      ..write(obj.lore)
      ..writeByte(16)
      ..write(obj.abilities)
      ..writeByte(17)
      ..write(obj.talents)
      ..writeByte(18)
      ..write(obj.cards)
      ..writeByte(19)
      ..write(obj.latestChampion)
      ..writeByte(20)
      ..write(obj.onFreeRotation)
      ..writeByte(22)
      ..write(obj.unlockCost);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChampionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChampionAbility _$ChampionAbilityFromJson(Map<String, dynamic> json) =>
    ChampionAbility(
      abilityId: json['abilityId'] as int,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      imageBlurHash: json['imageBlurHash'] as String?,
      damageType: json['damageType'] as String,
      cooldown: (json['cooldown'] as num).toDouble(),
      description: json['description'] as String,
    );

Map<String, dynamic> _$ChampionAbilityToJson(ChampionAbility instance) =>
    <String, dynamic>{
      'abilityId': instance.abilityId,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'imageBlurHash': instance.imageBlurHash,
      'damageType': instance.damageType,
      'cooldown': instance.cooldown,
      'description': instance.description,
    };

ChampionTalent _$ChampionTalentFromJson(Map<String, dynamic> json) =>
    ChampionTalent(
      talentId: json['talentId'] as int,
      talentId2: json['talentId2'] as int,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      cooldown: (json['cooldown'] as num).toDouble(),
      description: json['description'] as String,
      modifier: json['modifier'] as String,
      unlockLevel: json['unlockLevel'] as int?,
    );

Map<String, dynamic> _$ChampionTalentToJson(ChampionTalent instance) =>
    <String, dynamic>{
      'talentId': instance.talentId,
      'talentId2': instance.talentId2,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'cooldown': instance.cooldown,
      'description': instance.description,
      'modifier': instance.modifier,
      'unlockLevel': instance.unlockLevel,
    };

ChampionCard _$ChampionCardFromJson(Map<String, dynamic> json) => ChampionCard(
      cardId: json['cardId'] as int,
      cardId2: json['cardId2'] as int,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      imageBlurHash: json['imageBlurHash'] as String?,
      cooldown: (json['cooldown'] as num).toDouble(),
      description: json['description'] as String,
      modifier: json['modifier'] as String,
    );

Map<String, dynamic> _$ChampionCardToJson(ChampionCard instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
      'cardId2': instance.cardId2,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'imageBlurHash': instance.imageBlurHash,
      'cooldown': instance.cooldown,
      'description': instance.description,
      'modifier': instance.modifier,
    };

Tag _$TagFromJson(Map<String, dynamic> json) => Tag(
      name: json['name'] as String,
      color: json['color'] as String,
    );

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
      'name': instance.name,
      'color': instance.color,
    };

Champion _$ChampionFromJson(Map<String, dynamic> json) => Champion(
      championId: json['championId'] as int,
      name: json['name'] as String,
      iconUrl: json['iconUrl'] as String,
      iconBlurHash: json['iconBlurHash'] as String?,
      headerUrl: json['headerUrl'] as String,
      splashUrl: json['splashUrl'] as String,
      splashBlurHash: json['splashBlurHash'] as String?,
      title: json['title'] as String,
      role: json['role'] as String,
      releaseDate: DateTime.parse(json['releaseDate'] as String),
      health: (json['health'] as num).toDouble(),
      movementSpeed: (json['movementSpeed'] as num).toDouble(),
      damageFallOffRange: (json['damageFallOffRange'] as num).toDouble(),
      weaponDamage: (json['weaponDamage'] as num).toDouble(),
      fireRate: (json['fireRate'] as num).toDouble(),
      lore: json['lore'] as String,
      abilities: (json['abilities'] as List<dynamic>)
          .map((e) => ChampionAbility.fromJson(e as Map<String, dynamic>))
          .toList(),
      talents: (json['talents'] as List<dynamic>)
          .map((e) => ChampionTalent.fromJson(e as Map<String, dynamic>))
          .toList(),
      cards: (json['cards'] as List<dynamic>)
          .map((e) => ChampionCard.fromJson(e as Map<String, dynamic>))
          .toList(),
      latestChampion: json['latestChampion'] as bool,
      onFreeRotation: json['onFreeRotation'] as bool,
      unlockCost: json['unlockCost'] as int?,
    );

Map<String, dynamic> _$ChampionToJson(Champion instance) => <String, dynamic>{
      'championId': instance.championId,
      'name': instance.name,
      'iconUrl': instance.iconUrl,
      'iconBlurHash': instance.iconBlurHash,
      'headerUrl': instance.headerUrl,
      'splashUrl': instance.splashUrl,
      'splashBlurHash': instance.splashBlurHash,
      'title': instance.title,
      'role': instance.role,
      'releaseDate': instance.releaseDate.toIso8601String(),
      'health': instance.health,
      'movementSpeed': instance.movementSpeed,
      'damageFallOffRange': instance.damageFallOffRange,
      'weaponDamage': instance.weaponDamage,
      'fireRate': instance.fireRate,
      'lore': instance.lore,
      'abilities': instance.abilities,
      'talents': instance.talents,
      'cards': instance.cards,
      'latestChampion': instance.latestChampion,
      'onFreeRotation': instance.onFreeRotation,
      'unlockCost': instance.unlockCost,
    };
