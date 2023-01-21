import "package:json_annotation/json_annotation.dart";
import "package:paladinsedge/models/match/match.dart" show MatchPlayerStats;
import "package:paladinsedge/utilities/index.dart" as utilities;

part "player_inferred.g.dart";

@JsonSerializable()
class BasicPlayer {
  /// paladins player id
  final int playerId;

  /// name of the player in the game eg. tusharlock10
  final String name;

  /// Paladins title that appears below name eg. The 1%
  final String? title;

  /// image url of the avatar
  final String avatarUrl;

  ///  blur hash of the player avatar
  final String? avatarBlurHash;

  BasicPlayer({
    required this.playerId,
    required this.name,
    required String avatarUrl,
    this.avatarBlurHash,
    this.title,
  }) : avatarUrl = utilities.getUrlFromKey(avatarUrl);

  factory BasicPlayer.fromJson(Map<String, dynamic> json) =>
      _$BasicPlayerFromJson(json);
  Map<String, dynamic> toJson() => _$BasicPlayerToJson(this);
}

@JsonSerializable()
class PlayerInferred {
  /// paladins player id this data belongs to
  final int playerId;

  /// list of championIds, the player has played recently
  final List<int> recentlyPlayedChampions;

  // list of queues, the player has played recently
  final List<int> recentlyPlayedQueues;

  /// list of party members the player has played with the most
  final List<BasicPlayer> recentPartyMembers;

  /// average stats of the player across recently played matches
  final MatchPlayerStats averageStats;

  PlayerInferred({
    required this.playerId,
    required this.recentlyPlayedChampions,
    required this.recentlyPlayedQueues,
    required this.recentPartyMembers,
    required this.averageStats,
  });

  factory PlayerInferred.fromJson(Map<String, dynamic> json) =>
      _$PlayerInferredFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerInferredToJson(this);
}
