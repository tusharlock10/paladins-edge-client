// Contains the resposne classes from auth api
import 'package:json_annotation/json_annotation.dart';

import '../../Models/index.dart' show Champion, PlayerChampion;

part 'Responses.g.dart';

@JsonSerializable()
class AllChampionsResponse {
  final List<Champion> champions;

  AllChampionsResponse({required this.champions});

  factory AllChampionsResponse.fromJson(Map<String, dynamic> json) =>
      _$AllChampionsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AllChampionsResponseToJson(this);
}

@JsonSerializable()
class PlayerChampionsResponse {
  final List<PlayerChampion> playerChampions;

  PlayerChampionsResponse({required this.playerChampions});

  factory PlayerChampionsResponse.fromJson(Map<String, dynamic> json) =>
      _$PlayerChampionsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerChampionsResponseToJson(this);
}
