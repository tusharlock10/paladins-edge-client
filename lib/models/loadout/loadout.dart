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
  /// id of the champion that this belongs to
  final String championId;

  /// if of the player that loadout belongs to
  final String playerId;

  /// name of the loadout
  final String name;

  /// list of cards used in the loadout
  final List<LoadoutCard> loadoutCards;

  /// is the loadout imported from paladins api ro created by user from the app
  final bool isImported;

  /// hash of deckId if imported from paladins api
  /// else its a hash using uuid of is created
  final String? loadoutHash;

  Loadout({
    required this.championId,
    required this.playerId,
    required this.name,
    required this.loadoutCards,
    required this.isImported,
    this.loadoutHash,
  });

  factory Loadout.fromJson(Map<String, dynamic> json) =>
      _$LoadoutFromJson(json);
  Map<String, dynamic> toJson() => _$LoadoutToJson(this);
}

class DraftLoadout {
  final String championId;
  final String playerId;
  final String name;
  final List<LoadoutCard?> loadoutCards;
  final bool isImported;

  const DraftLoadout({
    required this.championId,
    required this.playerId,
    required this.name,
    required this.loadoutCards,
    this.isImported = false,
  });

  factory DraftLoadout.empty() {
    return DraftLoadout(
      championId: '',
      playerId: '',
      name: '',
      loadoutCards: List<LoadoutCard?>.filled(5, null),
      isImported: false,
    );
  }

  DraftLoadout copyWith({
    String? championId,
    String? playerId,
    String? name,
    List<LoadoutCard?>? loadoutCards,
    bool? isImported,
  }) {
    return DraftLoadout(
      championId: championId ?? this.championId,
      playerId: playerId ?? this.playerId,
      name: name ?? this.name,
      loadoutCards: loadoutCards ?? this.loadoutCards,
      isImported: isImported ?? this.isImported,
    );
  }
}
