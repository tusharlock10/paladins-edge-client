// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Champion.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AbilityAdapter extends TypeAdapter<_Ability> {
  @override
  final int typeId = 1;

  @override
  _Ability read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _Ability(
      abilityId: fields[0] as int,
      name: fields[1] as String,
      imageUrl: fields[2] as String,
      damageType: fields[3] as String,
      cooldown: fields[4] as int,
      description: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, _Ability obj) {
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

class TalentAdapter extends TypeAdapter<_Talent> {
  @override
  final int typeId = 2;

  @override
  _Talent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _Talent(
      talentId: fields[0] as int,
      name: fields[1] as String,
      imageUrl: fields[2] as String,
      cooldown: fields[3] as int,
      description: fields[4] as String,
      modifier: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, _Talent obj) {
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

class CardAdapter extends TypeAdapter<_Card> {
  @override
  final int typeId = 3;

  @override
  _Card read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _Card(
      cardId: fields[0] as int,
      name: fields[1] as String,
      imageUrl: fields[2] as String,
      cooldown: fields[3] as int,
      description: fields[4] as String,
      modifier: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, _Card obj) {
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
      id: fields[0] as String,
      dateCreated: fields[1] as DateTime,
      championId: fields[2] as int,
      name: fields[3] as String,
      iconUrl: fields[4] as String,
      headerUrl: fields[5] as String,
      splashUrl: fields[6] as String,
      title: fields[7] as String,
      role: fields[8] as String,
      releaseDate: fields[9] as DateTime,
      health: fields[10] as int,
      movementSpeed: fields[11] as int,
      damageFallOffRange: fields[12] as int,
      lore: fields[13] as String?,
      abilities: (fields[14] as List?)?.cast<_Ability>(),
      talents: (fields[15] as List?)?.cast<_Talent>(),
      cards: (fields[16] as List?)?.cast<_Card>(),
      latestChampion: fields[17] as bool,
      onFreeWeeklyRotation: fields[18] as bool,
      onFreeRotation: fields[19] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Champion obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.dateCreated)
      ..writeByte(2)
      ..write(obj.championId)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.iconUrl)
      ..writeByte(5)
      ..write(obj.headerUrl)
      ..writeByte(6)
      ..write(obj.splashUrl)
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
      ..write(obj.onFreeWeeklyRotation)
      ..writeByte(19)
      ..write(obj.onFreeRotation);
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
    id: json['_id'] as String,
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
      '_id': instance.id,
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
