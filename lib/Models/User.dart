import 'package:json_annotation/json_annotation.dart';
part 'User.g.dart';

@JsonSerializable()
class User {
  final String id;
  final String name;
  final String email;

  final String token; // token used for authentication

  final int? playerId; // the id of this user in paladins
  final String? playerName; // the name of this user in paladins

  final String photoUrl; // photo of the user
  final String uid; // uid provided by the oauth provider

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
    this.playerId,
    this.playerName,
    required this.photoUrl,
    required this.uid,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
