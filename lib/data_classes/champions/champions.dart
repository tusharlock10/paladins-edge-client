import 'package:json_annotation/json_annotation.dart';

part 'champions.g.dart';

@JsonSerializable()
class BatchPlayerChampionsPayload {
  final String playerId;
  final String championId;

  BatchPlayerChampionsPayload({
    required this.playerId,
    required this.championId,
  });

  factory BatchPlayerChampionsPayload.fromJson(Map<String, dynamic> json) =>
      _$BatchPlayerChampionsPayloadFromJson(json);
  Map<String, dynamic> toJson() => _$BatchPlayerChampionsPayloadToJson(this);
}
