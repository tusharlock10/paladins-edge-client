import "package:flutter/material.dart";
import "package:json_annotation/json_annotation.dart";

part "champions.g.dart";

@JsonSerializable()
class BatchPlayerChampionsPayload {
  final String playerId;
  final int championId;

  BatchPlayerChampionsPayload({
    required this.playerId,
    required this.championId,
  });

  factory BatchPlayerChampionsPayload.fromJson(Map<String, dynamic> json) =>
      _$BatchPlayerChampionsPayloadFromJson(json);
  Map<String, dynamic> toJson() => _$BatchPlayerChampionsPayloadToJson(this);
}

class ChampionDamage {
  final String name;
  final MaterialColor color;
  final IconData? icon;

  ChampionDamage({
    required this.name,
    required this.color,
    this.icon,
  });
}
