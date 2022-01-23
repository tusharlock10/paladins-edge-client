import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/models/index.dart' as models;

class _LoadoutNotifier extends ChangeNotifier {
  bool isSavingLoadout = false;
  models.DraftLoadout draftLoadout = models.DraftLoadout.empty();

  /// Creates a `draftLoaodut` to use to drafting loadout
  /// instanciates the loadout with championId and playerId
  void createDraftLoadout({
    required String championId,
    required String playerId,
  }) {
    draftLoadout = models.DraftLoadout(
      championId: championId,
      loadoutCards: List<models.LoadoutCard?>.filled(5, null),
      name: 'New Loadout',
      playerId: playerId,
    );
  }

  /// Reset the `draftLoadout` when user navigates back from draft loadout screen
  void resetDraftLoadout() {
    draftLoadout = models.DraftLoadout.empty();
  }

  /// Inserts the loadoutCard at the appropriate index
  /// when the user drags the card to dragTarget
  void onAcceptDragCard(models.Card card, int index) {
    final loadoutCardsClone = draftLoadout.loadoutCards;
    loadoutCardsClone[index] = models.LoadoutCard(
      cardId2: card.cardId2,
      level: 1,
    );
    draftLoadout = draftLoadout.copyWith(loadoutCards: loadoutCardsClone);

    notifyListeners();
  }

  /// Sets thevalue of loadoutCard level when user changes the slider
  void onSliderChange(models.LoadoutCard loadoutCard, int cardPoints) {
    // 1) find the index of loadoutCard in draftLoadout
    // 2) replace the loadoutCard with the new cardPoints value

    final loadoutCardsClone = draftLoadout.loadoutCards;
    final index =
        loadoutCardsClone.indexWhere((_) => _?.cardId2 == loadoutCard.cardId2);
    loadoutCardsClone[index] = models.LoadoutCard(
      cardId2: loadoutCard.cardId2,
      level: cardPoints,
    );
    draftLoadout = draftLoadout.copyWith(loadoutCards: loadoutCardsClone);

    notifyListeners();
  }

  /// Sets the loadoutName in draftLoadout and also validates the name
  bool onChangeLoadoutName(String name) {
    // changes and validates loadout name
    draftLoadout = draftLoadout.copyWith(name: name);

    return name.trim().isEmpty;
  }

  /// validates loadout before saving
  Map<String, Object> validateLoadout() {
    // check if loadout name is valid

    bool result = true;
    String error = '';

    if (draftLoadout.name.trim().isEmpty) {
      result = false;
      error = 'Loadout name cannot be empty';
    }

    // check if there are 5 loadout cards
    final filteredCards =
        draftLoadout.loadoutCards.where((_) => _ != null).toList();
    if (filteredCards.length < 5) {
      result = false;
      error = 'Loadout should have 5 cards';
    }

    int points = 0;
    for (var _ in filteredCards) {
      points += _?.level ?? 0;
    }

    // check if loadout points are exactly 15
    if (points != 15) {
      result = false;
      error = 'Loadout should have 15 points';
    }

    return {
      'result': result,
      'error': error,
    };
  }

  Future<void> saveLoadout() async {
    final loadout = models.Loadout(
      championId: draftLoadout.championId,
      playerId: draftLoadout.playerId,
      isImported: draftLoadout.isImported,
      loadoutCards: List<models.LoadoutCard>.from(draftLoadout.loadoutCards),
      name: draftLoadout.name,
    );

    isSavingLoadout = true;
    notifyListeners();

    await api.LoadoutRequests.savePlayerLoadout(loadout: loadout);

    isSavingLoadout = false;
    notifyListeners();
  }
}

/// Provider to handle loadout
final loadout = ChangeNotifierProvider((_) => _LoadoutNotifier());
