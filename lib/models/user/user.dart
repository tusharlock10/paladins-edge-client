import "package:hive/hive.dart";
import "package:json_annotation/json_annotation.dart";
import "package:paladinsedge/constants.dart" show TypeIds;

part "user.g.dart";

@HiveType(typeId: TypeIds.user)
@JsonSerializable()
class User {
  /// name of the user
  @HiveField(1)
  final String name;

  /// email of the user
  @HiveField(2)
  final String email;

  /// paladins playerId of the connected player
  @HiveField(5)
  final String? playerId;

  /// uid provided by the oauth provider
  @HiveField(6)
  final String uid;

  /// list of playerId of the user's favourite friends
  @HiveField(7)
  List<String> favouriteFriends;

  User({
    required this.name,
    required this.email,
    required this.uid,
    required this.favouriteFriends,
    this.playerId,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
