import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../Constants.dart' show TypeIds;

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
  @HiveField(3)
  final String token; // token used for authentication

  @HiveField(4)
  final String? playerId; // id of the connected player model

  @HiveField(5)
  final String photoUrl; // photo of the user
  @HiveField(6)
  final String uid; // uid provided by the oauth provider

  @HiveField(7)
  List<String> observeList; // the connected observe id for observing players
  @HiveField(8)
  List<String>
      favouriteFriends; // list of playerId of the user's favourite friends

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
    required this.photoUrl,
    required this.uid,
    this.playerId,
    required this.observeList,
    required this.favouriteFriends,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
