import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paladinsedge/constants.dart' show TypeIds;

part 'user.g.dart';

@HiveType(typeId: TypeIds.user)
@JsonSerializable()
class User {
  @JsonKey(name: '_id')
  @HiveField(0)
  final String id; // id of the user in db
  @HiveField(1)
  final String name; // name of the user
  @HiveField(2)
  final String email; // email of the user
  @HiveField(3)
  final String token; // token used for authentication
  @HiveField(4)
  final String? playerId; // paladins playerId of the connected player
  @HiveField(5)
  final String uid; // uid provided by the oauth provider
  @HiveField(6)
  List<String>
      favouriteFriends; // list of playerId of the user's favourite friends

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
