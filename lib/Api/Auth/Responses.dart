// Contains the resposne classes from auth api
import 'package:json_annotation/json_annotation.dart';

import '../../Models/index.dart' show User, Player;

part 'Responses.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginResponse {
  final User? user;
  final Player? player;

  LoginResponse({this.user, this.player});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
