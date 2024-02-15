import "package:json_annotation/json_annotation.dart";
import "package:paladinsedge/models/player/player.dart" show Ranked;
import "package:paladinsedge/models/player_inferred/player_inferred.dart"
    show BasicPlayer;

part "leaderboard_player.g.dart";

@JsonSerializable()
class LeaderboardPlayer {
  // position of the player on leaderboard
  final int position;

  // at which platform is he playing eg. Steam
  final String region;

  // from which region the player is eg. Europe
  final String platform;

  // basic player details
  final BasicPlayer basicPlayer;

  // ranked details of the player
  final Ranked ranked;

  LeaderboardPlayer({
    required this.position,
    required this.region,
    required this.platform,
    required this.basicPlayer,
    required this.ranked,
  });

  factory LeaderboardPlayer.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardPlayerFromJson(json);
  Map<String, dynamic> toJson() => _$LeaderboardPlayerToJson(this);
}
