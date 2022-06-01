import "package:json_annotation/json_annotation.dart";
import "package:paladinsedge/data_classes/index.dart" show DraftLoadout;

part "loadout.g.dart";

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
  final int championId;

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

  factory Loadout.fromDraftLoadout(DraftLoadout draftLoadout) {
    return Loadout(
      championId: draftLoadout.championId,
      playerId: draftLoadout.playerId,
      isImported: draftLoadout.isImported,
      loadoutCards: List<LoadoutCard>.from(draftLoadout.loadoutCards),
      name: draftLoadout.name,
      loadoutHash: draftLoadout.loadoutHash,
    );
  }

  factory Loadout.fromJson(Map<String, dynamic> json) =>
      _$LoadoutFromJson(json);
  Map<String, dynamic> toJson() => _$LoadoutToJson(this);
}
