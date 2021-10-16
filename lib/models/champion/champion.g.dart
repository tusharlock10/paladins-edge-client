// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'champion.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AbilityAdapter extends TypeAdapter<Ability> {
  @override
  final int typeId = 1;

  @override
  Ability read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Ability(
      abilityId: fields[0] as int,
      name: fields[1] as String,
      imageUrl: fields[2] as String,
      damageType: fields[3] as String,
      cooldown: fields[4] as double,
      description: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Ability obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.abilityId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.imageUrl)
      ..writeByte(3)
      ..write(obj.damageType)
      ..writeByte(4)
      ..write(obj.cooldown)
      ..writeByte(5)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AbilityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TalentAdapter extends TypeAdapter<Talent> {
  @override
  final int typeId = 2;

  @override
  Talent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Talent(
      talentId: fields[0] as int,
      name: fields[1] as String,
      imageUrl: fields[2] as String,
      cooldown: fields[3] as double,
      description: fields[4] as String,
      modifier: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Talent obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.talentId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.imageUrl)
      ..writeByte(3)
      ..write(obj.cooldown)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.modifier);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TalentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CardAdapter extends TypeAdapter<Card> {
  @override
  final int typeId = 3;

  @override
  Card read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Card(
      cardId: fields[0] as int,
      name: fields[1] as String,
      imageUrl: fields[2] as String,
      cooldown: fields[3] as double,
      description: fields[4] as String,
      modifier: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Card obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.cardId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.imageUrl)
      ..writeByte(3)
      ..write(obj.cooldown)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.modifier);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardAdapter &&
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
      championId: fields[0] as String,
      name: fields[1] as String,
      iconUrl: fields[2] as String,
      headerUrl: fields[3] as String,
      splashUrl: fields[4] as String,
      title: fields[5] as String,
      role: fields[6] as String,
      releaseDate: fields[7] as DateTime,
      health: fields[8] as double,
      movementSpeed: fields[9] as double,
      damageFallOffRange: fields[10] as double,
      weaponDamage: fields[11] as double,
      fireRate: fields[12] as double,
      lore: fields[13] as String?,
      abilities: (fields[14] as List?)?.cast<Ability>(),
      talents: (fields[15] as List?)?.cast<Talent>(),
      cards: (fields[16] as List?)?.cast<Card>(),
      latestChampion: fields[17] as bool,
      onFreeRotation: fields[18] as bool,
      tags: (fields[19] as List).cast<Tag>(),
    );
  }

  @override
  void write(BinaryWriter writer, Champion obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.championId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.iconUrl)
      ..writeByte(3)
      ..write(obj.headerUrl)
      ..writeByte(4)
      ..write(obj.splashUrl)
      ..writeByte(5)
      ..write(obj.title)
      ..writeByte(6)
      ..write(obj.role)
      ..writeByte(7)
      ..write(obj.releaseDate)
      ..writeByte(8)
      ..write(obj.health)
      ..writeByte(9)
      ..write(obj.movementSpeed)
      ..writeByte(10)
      ..write(obj.damageFallOffRange)
      ..writeByte(11)
      ..write(obj.weaponDamage)
      ..writeByte(12)
      ..write(obj.fireRate)
      ..writeByte(13)
      ..write(obj.lore)
      ..writeByte(14)
      ..write(obj.abilities)
      ..writeByte(15)
      ..write(obj.talents)
      ..writeByte(16)
      ..write(obj.cards)
      ..writeByte(17)
      ..write(obj.latestChampion)
      ..writeByte(18)
      ..write(obj.onFreeRotation)
      ..writeByte(19)
      ..write(obj.tags);
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

Ability _$AbilityFromJson(Map<String, dynamic> json) => Ability(
      abilityId: json['abilityId'] as int,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      damageType: json['damageType'] as String,
      cooldown: (json['cooldown'] as num).toDouble(),
      description: json['description'] as String,
    );

Map<String, dynamic> _$AbilityToJson(Ability instance) => <String, dynamic>{
      'abilityId': instance.abilityId,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'damageType': instance.damageType,
      'cooldown': instance.cooldown,
      'description': instance.description,
    };

Talent _$TalentFromJson(Map<String, dynamic> json) => Talent(
      talentId: json['talentId'] as int,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      cooldown: (json['cooldown'] as num).toDouble(),
      description: json['description'] as String,
      modifier: json['modifier'] as String,
    );

Map<String, dynamic> _$TalentToJson(Talent instance) => <String, dynamic>{
      'talentId': instance.talentId,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'cooldown': instance.cooldown,
      'description': instance.description,
      'modifier': instance.modifier,
    };

Card _$CardFromJson(Map<String, dynamic> json) => Card(
      cardId: json['cardId'] as int,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      cooldown: (json['cooldown'] as num).toDouble(),
      description: json['description'] as String,
      modifier: json['modifier'] as String,
    );

Map<String, dynamic> _$CardToJson(Card instance) => <String, dynamic>{
      'cardId': instance.cardId,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
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
      championId: json['championId'] as String,
      name: json['name'] as String,
      iconUrl: json['iconUrl'] as String,
      headerUrl: json['headerUrl'] as String,
      splashUrl: json['splashUrl'] as String,
      title: json['title'] as String,
      role: json['role'] as String,
      releaseDate: DateTime.parse(json['releaseDate'] as String),
      health: (json['health'] as num).toDouble(),
      movementSpeed: (json['movementSpeed'] as num).toDouble(),
      damageFallOffRange: (json['damageFallOffRange'] as num).toDouble(),
      weaponDamage: (json['weaponDamage'] as num).toDouble(),
      fireRate: (json['fireRate'] as num).toDouble(),
      lore: json['lore'] as String?,
      abilities: (json['abilities'] as List<dynamic>?)
          ?.map((e) => Ability.fromJson(e as Map<String, dynamic>))
          .toList(),
      talents: (json['talents'] as List<dynamic>?)
          ?.map((e) => Talent.fromJson(e as Map<String, dynamic>))
          .toList(),
      cards: (json['cards'] as List<dynamic>?)
          ?.map((e) => Card.fromJson(e as Map<String, dynamic>))
          .toList(),
      latestChampion: json['latestChampion'] as bool,
      onFreeRotation: json['onFreeRotation'] as bool,
      tags: (json['tags'] as List<dynamic>)
          .map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChampionToJson(Champion instance) => <String, dynamic>{
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
      'weaponDamage': instance.weaponDamage,
      'fireRate': instance.fireRate,
      'lore': instance.lore,
      'abilities': instance.abilities,
      'talents': instance.talents,
      'cards': instance.cards,
      'latestChampion': instance.latestChampion,
      'onFreeRotation': instance.onFreeRotation,
      'tags': instance.tags,
    };
