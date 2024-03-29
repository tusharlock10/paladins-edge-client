import "package:json_annotation/json_annotation.dart";
import "package:paladinsedge/models/index.dart"
    show Match, MatchPlayer, TopMatch;

part "responses.g.dart";

@JsonSerializable()
class MatchDetailsResponse {
  final Match match;
  final List<MatchPlayer> matchPlayers;

  MatchDetailsResponse({
    required this.match,
    required this.matchPlayers,
  });

  factory MatchDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$MatchDetailsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MatchDetailsResponseToJson(this);
}

@JsonSerializable()
class PlayerMatchesResponse {
  final List<Match> matches;
  final List<MatchPlayer> matchPlayers;

  PlayerMatchesResponse({
    required this.matches,
    required this.matchPlayers,
  });

  factory PlayerMatchesResponse.fromJson(Map<String, dynamic> json) =>
      _$PlayerMatchesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerMatchesResponseToJson(this);
}

@JsonSerializable()
class CommonMatchesResponse {
  final List<Match> matches;
  final List<MatchPlayer> matchPlayers;

  CommonMatchesResponse({
    required this.matches,
    required this.matchPlayers,
  });

  factory CommonMatchesResponse.fromJson(Map<String, dynamic> json) =>
      _$CommonMatchesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CommonMatchesResponseToJson(this);
}

@JsonSerializable()
class TopMatchesResponse {
  final List<TopMatch> topMatches;

  TopMatchesResponse({
    required this.topMatches,
  });

  factory TopMatchesResponse.fromJson(Map<String, dynamic> json) =>
      _$TopMatchesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TopMatchesResponseToJson(this);
}
