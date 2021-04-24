import 'package:json_annotation/json_annotation.dart';
part 'User.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String email;

  final String token; // token used for authentication

  final String? playerId; // id of the connected player model
  final int? paladinsPlayerId; // id of the player for paladins API

  final String photoUrl; // photo of the user
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
