import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/create_loadout/create_loadout_target.dart';
import 'package:paladinsedge/screens/create_loadout/draggable_cards.dart';

class CreateLoadout extends HookConsumerWidget {
  static const routeName = '/createLoadout';

  const CreateLoadout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final authProvider = ref.read(providers.auth);

    // Variables
    final champion =
        ModalRoute.of(context)?.settings.arguments as models.Champion;

    // State
    final draftLoadout = useState<models.DraftLoadout>(
      models.DraftLoadout(
        championId: champion.championId,
        loadoutCards: List<models.LoadoutCard?>.filled(5, null),
        name: 'New Loadout',
        playerId: authProvider.player!.playerId,
      ),
    );

    // Methods
    final onWillAcceptCard = useCallback(
      (models.Card? card) {
        // if this card is already present in draftLoadout.value.loadoutCards
        // then do not accept it
        final exists = draftLoadout.value.loadoutCards
            .indexWhere((_) => _?.cardId2 == card?.cardId2);

        // return true if not exists
        return exists == -1;
      },
      [],
    );

    final onAcceptDragCard = useCallback(
      (models.Card card, int index) {
        final loadoutCardsClone = draftLoadout.value.loadoutCards;
        loadoutCardsClone[index] = models.LoadoutCard(
          cardId2: card.cardId2,
          level: 1,
        );
        draftLoadout.value =
            draftLoadout.value.copyWith(loadoutCards: loadoutCardsClone);
      },
      [],
    );

    final onSliderChange = useCallback(
      (models.LoadoutCard loadoutCard, int cardPoints) {
        // 1) find the index of loadoutCard in draftLoadout
        // 2) replace the loadoutCard with the new cardPoints value

        final loadoutCardsClone = draftLoadout.value.loadoutCards;
        final index = loadoutCardsClone
            .indexWhere((_) => _?.cardId2 == loadoutCard.cardId2);
        loadoutCardsClone[index] = models.LoadoutCard(
          cardId2: loadoutCard.cardId2,
          level: cardPoints,
        );
        draftLoadout.value =
            draftLoadout.value.copyWith(loadoutCards: loadoutCardsClone);
      },
      [],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Loadout'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CreateLoadoutTarget(
            draftLoadout: draftLoadout.value,
            champion: champion,
            onWillAcceptCard: onWillAcceptCard,
            onAcceptDragCard: onAcceptDragCard,
            onSliderChange: onSliderChange,
          ),
          const DraggableCards(),
        ],
      ),
    );
  }
}
