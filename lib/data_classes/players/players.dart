import "package:json_annotation/json_annotation.dart";
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/models/index.dart" show Player, ActiveMatch;

part "players.g.dart";

class LoadoutItem {
  final models.ChampionCard? card;
  final int cardLevel;

  const LoadoutItem({
    required this.card,
    required this.cardLevel,
  });
}

class StatLabelGridProps {
  double itemHeight;
  double itemWidth;
  int crossAxisCount;

  StatLabelGridProps({
    required this.itemHeight,
    required this.itemWidth,
    required this.crossAxisCount,
  });
}

class RecentWinStats {
  final int normalMatches;
  final int normalWins;
  final int rankedMatches;
  final int rankedWins;

  const RecentWinStats({
    required this.normalMatches,
    required this.normalWins,
    required this.rankedMatches,
    required this.rankedWins,
  });
}

@JsonSerializable()
class LowerSearch {
  final String name;
  final int playerId;
  final String platform;

  LowerSearch({
    required this.name,
    required this.playerId,
    required this.platform,
  });

  factory LowerSearch.fromJson(Map<String, dynamic> json) =>
      _$LowerSearchFromJson(json);
  Map<String, dynamic> toJson() => _$LowerSearchToJson(this);
}

@JsonSerializable()
class SearchPlayersData {
  final List<Player> topSearchPlayers;
  final List<LowerSearch> lowerSearchPlayers;
  final bool exactMatch;
  final Player? player;

  SearchPlayersData({
    required this.topSearchPlayers,
    required this.lowerSearchPlayers,
    required this.exactMatch,
    this.player,
  });

  factory SearchPlayersData.fromJson(Map<String, dynamic> json) =>
      _$SearchPlayersDataFromJson(json);
  Map<String, dynamic> toJson() => _$SearchPlayersDataToJson(this);
}

@JsonSerializable()
class PlayerStatus {
  final int playerId;
  final bool inMatch;
  final String status;
  final ActiveMatch? match;

  PlayerStatus({
    required this.playerId,
    required this.inMatch,
    required this.status,
    required this.match,
  });

  factory PlayerStatus.fromJson(Map<String, dynamic> json) =>
      _$PlayerStatusFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerStatusToJson(this);
}
