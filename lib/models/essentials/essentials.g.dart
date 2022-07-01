// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'essentials.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EssentialsAdapter extends TypeAdapter<Essentials> {
  @override
  final int typeId = 10;

  @override
  Essentials read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Essentials(
      version: fields[0] as String,
      imageBaseUrl: fields[1] as String,
      forceUpdateFriendsDuration: fields[4] as int,
      forceUpdateMatchesDuration: fields[5] as int,
      forceUpdatePlayerDuration: fields[6] as int,
      forceUpdateChampionsDuration: fields[7] as int,
      maxFavouriteFriends: fields[2] as int,
      maxSavedMatches: fields[3] as int,
      forceUpdatePlayerLoadouts: fields[8] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Essentials obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.version)
      ..writeByte(1)
      ..write(obj.imageBaseUrl)
      ..writeByte(2)
      ..write(obj.maxFavouriteFriends)
      ..writeByte(3)
      ..write(obj.maxSavedMatches)
      ..writeByte(4)
      ..write(obj.forceUpdateFriendsDuration)
      ..writeByte(5)
      ..write(obj.forceUpdateMatchesDuration)
      ..writeByte(6)
      ..write(obj.forceUpdatePlayerDuration)
      ..writeByte(7)
      ..write(obj.forceUpdateChampionsDuration)
      ..writeByte(8)
      ..write(obj.forceUpdatePlayerLoadouts);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EssentialsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Essentials _$EssentialsFromJson(Map<String, dynamic> json) => Essentials(
      version: json['version'] as String,
      imageBaseUrl: json['imageBaseUrl'] as String,
      forceUpdateFriendsDuration: json['forceUpdateFriendsDuration'] as int,
      forceUpdateMatchesDuration: json['forceUpdateMatchesDuration'] as int,
      forceUpdatePlayerDuration: json['forceUpdatePlayerDuration'] as int,
      forceUpdateChampionsDuration: json['forceUpdateChampionsDuration'] as int,
      maxFavouriteFriends: json['maxFavouriteFriends'] as int,
      maxSavedMatches: json['maxSavedMatches'] as int,
      forceUpdatePlayerLoadouts: json['forceUpdatePlayerLoadouts'] as int,
    );

Map<String, dynamic> _$EssentialsToJson(Essentials instance) =>
    <String, dynamic>{
      'version': instance.version,
      'imageBaseUrl': instance.imageBaseUrl,
      'maxFavouriteFriends': instance.maxFavouriteFriends,
      'maxSavedMatches': instance.maxSavedMatches,
      'forceUpdateFriendsDuration': instance.forceUpdateFriendsDuration,
      'forceUpdateMatchesDuration': instance.forceUpdateMatchesDuration,
      'forceUpdatePlayerDuration': instance.forceUpdatePlayerDuration,
      'forceUpdateChampionsDuration': instance.forceUpdateChampionsDuration,
      'forceUpdatePlayerLoadouts': instance.forceUpdatePlayerLoadouts,
    };
