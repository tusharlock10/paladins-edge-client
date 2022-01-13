// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 6;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      name: fields[1] as String,
      email: fields[2] as String,
      uid: fields[6] as String,
      favouriteFriends: (fields[7] as List).cast<String>(),
      playerId: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(5)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.playerId)
      ..writeByte(6)
      ..write(obj.uid)
      ..writeByte(7)
      ..write(obj.favouriteFriends);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String,
      email: json['email'] as String,
      uid: json['uid'] as String,
      favouriteFriends: (json['favouriteFriends'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      playerId: json['playerId'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'playerId': instance.playerId,
      'uid': instance.uid,
      'favouriteFriends': instance.favouriteFriends,
    };
