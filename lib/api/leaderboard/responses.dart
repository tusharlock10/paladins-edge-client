import "package:json_annotation/json_annotation.dart";
import "package:paladinsedge/models/index.dart" show LeaderboardPlayer;

part "responses.g.dart";

@JsonSerializable()
class LeaderboardPlayerResponse {
  final List<LeaderboardPlayer> leaderboardPlayers;

  LeaderboardPlayerResponse({required this.leaderboardPlayers});

  factory LeaderboardPlayerResponse.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardPlayerResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LeaderboardPlayerResponseToJson(this);
}
