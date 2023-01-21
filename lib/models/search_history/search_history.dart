import "package:hive/hive.dart";
import "package:json_annotation/json_annotation.dart";
import "package:paladinsedge/constants/index.dart" show TypeIds;

part "search_history.g.dart";

// model for storing user user's searchHistory locally
@HiveType(typeId: TypeIds.searchHistory)
@JsonSerializable()
class SearchHistory extends HiveObject {
  /// id of the searched player
  @HiveField(0)
  final int playerId;

  /// name of the searched player
  @HiveField(1)
  final String playerName;

  /// time at which the search took place
  @HiveField(2)
  final DateTime time;

  SearchHistory({
    required this.playerId,
    required this.playerName,
    required this.time,
  });

  factory SearchHistory.fromJson(Map<String, dynamic> json) =>
      _$SearchHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$SearchHistoryToJson(this);
}
