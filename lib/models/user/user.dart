import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paladinsedge/constants.dart' show TypeIds;

part 'user.g.dart';

@HiveType(typeId: TypeIds.user)
@JsonSerializable()
class User {
  /// id of the user in db
  @JsonKey(name: '_id')
  @HiveField(0)
  final String id;

  /// name of the user
  @HiveField(1)
  final String name;

  /// email of the user
  @HiveField(2)
  final String email;

  /// token used for authentication
  @HiveField(3)
  final String token;

  /// paladins playerId of the connected player
  @HiveField(4)
  final String? playerId;

  /// uid provided by the oauth provider
  @HiveField(5)
  final String uid;

  /// list of playerId of the user's favourite friends
  @HiveField(6)
  List<String> favouriteFriends;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
    required this.uid,
    required this.favouriteFriends,
    this.playerId,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
