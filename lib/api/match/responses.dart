import 'package:json_annotation/json_annotation.dart';
import 'package:paladinsedge/models/index.dart' show Match, MatchPlayer;

part 'responses.g.dart';

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
