import "package:hive/hive.dart";
import "package:json_annotation/json_annotation.dart";
import "package:paladinsedge/constants/index.dart" show TypeIds;
import "package:paladinsedge/utilities/index.dart" as utilities;

part "base_rank.g.dart";

@HiveType(typeId: TypeIds.baseRank)
@JsonSerializable()
class BaseRank {
  /// the rank of the player in number in numbers eg. 1 if bronze 5
  @HiveField(0)
  final int rank;

  /// the rank of the player in string eg. Master
  @HiveField(1)
  final String rankName;

  /// image url of the rank icon
  @HiveField(2)
  final String rankIconUrl;

  BaseRank({
    required this.rank,
    required this.rankName,
    required String rankIconUrl,
  }) : rankIconUrl = utilities.getUrlFromKey(rankIconUrl);

  factory BaseRank.fromJson(Map<String, dynamic> json) =>
      _$BaseRankFromJson(json);
  Map<String, dynamic> toJson() => _$BaseRankToJson(this);
}
