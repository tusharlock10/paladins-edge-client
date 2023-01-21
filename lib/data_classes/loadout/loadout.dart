import "package:flutter/material.dart" show Color, BuildContext;
import "package:freezed_annotation/freezed_annotation.dart";
import "package:paladinsedge/models/index.dart"
    show Champion, Loadout, LoadoutCard, ChampionCard;

part "loadout.freezed.dart";

@freezed
class LoadoutValidationResult with _$LoadoutValidationResult {
  factory LoadoutValidationResult({
    required bool result,
    required String error,
  }) = _LoadoutValidationResult;
}

@freezed
class DraftLoadout with _$DraftLoadout {
  factory DraftLoadout({
    required int championId,
    required int playerId,
    required String name,
    required List<LoadoutCard?> loadoutCards,
    required bool isImported,
    int? loadoutHash,
  }) = _DraftLoadout;

  factory DraftLoadout.empty() {
    return DraftLoadout(
      championId: 0,
      playerId: 0,
      name: "New Loadout",
      loadoutCards: List<LoadoutCard?>.filled(5, null),
      isImported: false,
    );
  }

  factory DraftLoadout.fromLoadout(Loadout loadout) {
    return DraftLoadout(
      championId: loadout.championId,
      playerId: loadout.playerId,
      name: loadout.name,
      loadoutCards: loadout.loadoutCards,
      isImported: loadout.isImported,
      loadoutHash: loadout.loadoutHash,
    );
  }
}

class ShowLoadoutDetailsOptions {
  final BuildContext context;
  final Champion champion;
  final ChampionCard card;
  final bool sliderFixed;
  int cardPoints;
  void Function(int)? onSliderChange;

  ShowLoadoutDetailsOptions({
    required this.context,
    required this.champion,
    required this.card,
    required this.sliderFixed,
    this.cardPoints = 1,
    this.onSliderChange,
  });
}

class LoadoutPoints {
  final int points;
  final Color color;

  const LoadoutPoints({
    required this.points,
    required this.color,
  });
}
