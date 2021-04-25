import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

import '../Constants.dart' show TypeIds;

part 'User.g.dart';

@HiveType(typeId: TypeIds.User)
@JsonSerializable()
class User {
  @JsonKey(name: '_id')
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String email;
  @HiveField(4)
  final String token; // token used for authentication

  @HiveField(5)
  final String? playerId; // id of the connected player model
  @HiveField(6)
  final int? paladinsPlayerId; // id of the player for paladins API

  @HiveField(7)
  final String photoUrl; // photo of the user
  @HiveField(8)
  final String uid; // uid provided by the oauth provider

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
    required this.photoUrl,
    required this.uid,
    this.playerId,
    this.paladinsPlayerId,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
