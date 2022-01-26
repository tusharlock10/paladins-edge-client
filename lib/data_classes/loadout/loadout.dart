import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:paladinsedge/models/index.dart'
    show Champion, Loadout, LoadoutCard;

part 'loadout.freezed.dart';

@freezed
class CreateLoadoutScreenArguments with _$CreateLoadoutScreenArguments {
  factory CreateLoadoutScreenArguments({
    required Champion champion,
    Loadout? loadout,
  }) = _CreateLoadoutScreenArguments;
}

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
    required String championId,
    required String playerId,
    required String name,
    required List<LoadoutCard?> loadoutCards,
    required bool isImported,
    String? loadoutHash,
  }) = _DraftLoadout;

  factory DraftLoadout.empty() {
    return DraftLoadout(
      championId: '',
      playerId: '',
      name: 'New Loadout',
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
