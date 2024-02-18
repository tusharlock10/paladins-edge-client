import "package:json_annotation/json_annotation.dart";
import "package:paladinsedge/models/index.dart" show BaseRank;

part "responses.g.dart";

@JsonSerializable()
class BaseRankResponse {
  final List<BaseRank> ranks;

  BaseRankResponse({
    required this.ranks,
  });

  factory BaseRankResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseRankResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BaseRankResponseToJson(this);
}
