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
      id: fields[0] as String,
      name: fields[1] as String,
      email: fields[2] as String,
      token: fields[3] as String,
      uid: fields[5] as String,
      observeList: (fields[6] as List).cast<String>(),
      favouriteFriends: (fields[7] as List).cast<String>(),
      playerId: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.token)
      ..writeByte(4)
      ..write(obj.playerId)
      ..writeByte(5)
      ..write(obj.uid)
      ..writeByte(6)
      ..write(obj.observeList)
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
      id: json['_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      token: json['token'] as String,
      uid: json['uid'] as String,
      observeList: (json['observeList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      favouriteFriends: (json['favouriteFriends'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      playerId: json['playerId'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'token': instance.token,
      'playerId': instance.playerId,
      'uid': instance.uid,
      'observeList': instance.observeList,
      'favouriteFriends': instance.favouriteFriends,
    };
