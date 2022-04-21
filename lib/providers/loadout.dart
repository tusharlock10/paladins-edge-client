import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/data_classes/index.dart' as data_classes;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/utilities/index.dart' as utilities;

class _LoadoutNotifier extends ChangeNotifier {
  bool isGettingLoadouts = false;
  bool isSavingLoadout = false;
  bool isEditingLoadout = false; // if false, means user is creating new loadout
  List<models.Loadout>? loadouts;
  data_classes.DraftLoadout draftLoadout = data_classes.DraftLoadout.empty();

  /// Get the `loadouts` data for the champion of that player
  Future<void> getPlayerLoadouts({
    required String playerId,
    required int championId,
    bool forceUpdate = false,
  }) async {
    if (!forceUpdate) {
      isGettingLoadouts = true;
      utilities.postFrameCallback(notifyListeners);
    }

    final response = await api.LoadoutRequests.playerLoadouts(
      playerId: playerId,
      championId: championId,
      forceUpdate: forceUpdate,
    );

    if (!forceUpdate) isGettingLoadouts = false;
    if (response != null) loadouts = response.loadouts;

    utilities.postFrameCallback(notifyListeners);
  }

  /// Deletes the loadouts
  void resetPlayerLoadouts() {
    loadouts = null;
  }

  /// Creates a `draftLoadout` to use to drafting loadout
  /// instantiates the loadout with championId and playerId
  void createDraftLoadout({
    required int championId,
    required String playerId,
    required models.Loadout? loadout,
  }) {
    isEditingLoadout = loadout != null;
    draftLoadout = loadout != null
        ? data_classes.DraftLoadout.fromLoadout(loadout)
        : draftLoadout.copyWith(
            championId: championId,
            playerId: playerId,
          );
  }

  /// Reset the `draftLoadout` when user navigates back from draft loadout screen
  void resetDraftLoadout() {
    draftLoadout = data_classes.DraftLoadout.empty();
    isSavingLoadout = false;
    isEditingLoadout = false;
  }

  /// Inserts the loadoutCard at the appropriate index
  /// when the user drags the card to dragTarget
  void onAcceptDragCard(models.Card card, int index) {
    final loadoutCardsClone = [...draftLoadout.loadoutCards];
    loadoutCardsClone[index] = models.LoadoutCard(
      cardId2: card.cardId2,
      level: 1,
    );

    draftLoadout = draftLoadout.copyWith(loadoutCards: loadoutCardsClone);
    utilities.postFrameCallback(notifyListeners);
  }

  /// Sets the value of loadoutCard level when user changes the slider
  void onSliderChange(models.LoadoutCard loadoutCard, int cardPoints) {
    // 1) find the index of loadoutCard in draftLoadout
    // 2) replace the loadoutCard with the new cardPoints value

    final loadoutCardsClone = [...draftLoadout.loadoutCards];
    final index =
        loadoutCardsClone.indexWhere((_) => _?.cardId2 == loadoutCard.cardId2);
    loadoutCardsClone[index] = models.LoadoutCard(
      cardId2: loadoutCard.cardId2,
      level: cardPoints,
    );

    draftLoadout = draftLoadout.copyWith(loadoutCards: loadoutCardsClone);
    utilities.postFrameCallback(notifyListeners);
  }

  /// Sets the loadoutName in draftLoadout and also validates the name
  bool onChangeLoadoutName(String name) {
    // changes and validates loadout name
    draftLoadout = draftLoadout.copyWith(name: name);

    return name.trim().isEmpty;
  }

  /// validates loadout before saving
  data_classes.LoadoutValidationResult validateLoadout() {
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

    return data_classes.LoadoutValidationResult(
      error: error,
      result: result,
    );
  }

  /// saves or updates the loadout based on
  /// if the loadout is being edited
  Future<bool> saveLoadout() async {
    final loadout = models.Loadout.fromDraftLoadout(draftLoadout);

    isSavingLoadout = true;
    utilities.postFrameCallback(notifyListeners);

    final result = isEditingLoadout
        ? await api.LoadoutRequests.updatePlayerLoadout(loadout: loadout)
        : await api.LoadoutRequests.savePlayerLoadout(loadout: loadout);

    if (result != null) {
      _updateLoadouts(result.loadout);
    }

    isSavingLoadout = false;
    utilities.postFrameCallback(notifyListeners);

    return result != null;
  }

  /// Clears all user sensitive data upon logout
  void clearData() {
    isGettingLoadouts = true;
    isSavingLoadout = false;
    isEditingLoadout = false;
    loadouts = null;
    draftLoadout = data_classes.DraftLoadout.empty();
  }

  void _updateLoadouts(models.Loadout loadout) {
    if (loadouts == null || loadouts!.isEmpty) return;

    final loadoutsClone = [...loadouts!];

    final index =
        loadoutsClone.indexWhere((_) => _.loadoutHash == loadout.loadoutHash);
    if (index != -1) {
      loadoutsClone[index] = loadout;
    } else {
      loadoutsClone.add(loadout);
    }

    loadouts = loadoutsClone;
  }
}

/// Provider to handle loadout
final loadout = ChangeNotifierProvider((_) => _LoadoutNotifier());
