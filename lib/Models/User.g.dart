// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    token: json['token'] as String,
    photoUrl: json['photoUrl'] as String,
    uid: json['uid'] as String,
    playerId: json['playerId'] as String?,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'token': instance.token,
      'playerId': instance.playerId,
      'photoUrl': instance.photoUrl,
      'uid': instance.uid,
    };
