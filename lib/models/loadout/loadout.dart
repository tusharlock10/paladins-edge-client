import 'package:json_annotation/json_annotation.dart';

part 'loadout.g.dart';

@JsonSerializable()
class LoadoutCard {
  final int cardId2;
  final int level;

  LoadoutCard({
    required this.cardId2,
    required this.level,
  });

  factory LoadoutCard.fromJson(Map<String, dynamic> json) =>
      _$LoadoutCardFromJson(json);
  Map<String, dynamic> toJson() => _$LoadoutCardToJson(this);
}

@JsonSerializable()
class Loadout {
  final String loadoutHash;
  final String championId;
  final String playerId;
  final String name;
  final List<LoadoutCard> loadoutCards;
  final bool isImported;

  Loadout({
    required this.loadoutHash,
    required this.championId,
    required this.playerId,
    required this.name,
    required this.loadoutCards,
    required this.isImported,
  });

  factory Loadout.fromJson(Map<String, dynamic> json) =>
      _$LoadoutFromJson(json);
  Map<String, dynamic> toJson() => _$LoadoutToJson(this);
}
