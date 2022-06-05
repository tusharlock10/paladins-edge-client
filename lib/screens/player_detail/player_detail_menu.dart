import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/index.dart" as screens;
import "package:paladinsedge/screens/player_detail/player_detail_filter_modal.dart";
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

class PlayerDetailMenu extends HookConsumerWidget {
  const PlayerDetailMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final playersProvider = ref.read(providers.players);
    final player = ref.watch(providers.players.select((_) => _.playerData));
    final playerStatus = ref.watch(
      providers.players.select((_) => _.playerStatus),
    );

    // Variables
    final status = playerStatus?.status;
    final isOnline = status != null &&
        status.toLowerCase() != "offline" &&
        status.toLowerCase() != "unknown";

    // Methods
    final onPressActiveMatch = useCallback(
      () {
        if (player == null) return;

        playersProvider.setPlayerStatusPlayerId(player.playerId);
        utilities.Navigation.pop(context);
        utilities.Navigation.navigate(
          context,
          screens.ActiveMatch.routeName,
          params: {"playerId": player.playerId},
        );
      },
      [player],
    );

    final onPressFriends = useCallback(
      () {
        if (player == null) return;

        utilities.Navigation.pop(context);
        utilities.Navigation.navigate(
          context,
          screens.Friends.routeName,
          params: {
            "playerId": player.playerId,
          },
        );
      },
      [player],
    );

    final onPressChamps = useCallback(
      () {
        if (player == null) return;

        utilities.Navigation.pop(context);
        utilities.Navigation.navigate(
          context,
          screens.PlayerChampions.routeName,
          params: {
            "playerId": player.playerId,
          },
        );
      },
      [player],
    );

    final onFilter = useCallback(
      () {
        utilities.Navigation.pop(context);
        showPlayerDetailFilterModal(context);
      },
      [],
    );

    return PopupMenuButton(
      icon: const Icon(
        FeatherIcons.moreVertical,
        color: Colors.white,
      ),
      itemBuilder: (_) => <PopupMenuEntry>[
        const PopupMenuItem(
          enabled: false,
          height: 24,
          child: Center(child: Text("player actions")),
        ),
        const PopupMenuDivider(height: 10),
        PopupMenuItem(
          enabled: false,
          child: widgets.Button(
            label: "Active Match",
            disabled: !isOnline,
            elevation: 4,
            onPressed: onPressActiveMatch,
            color: Colors.green,
          ),
        ),
        PopupMenuItem(
          enabled: false,
          child: widgets.Button(
            label: "Friends",
            elevation: 4,
            onPressed: onPressFriends,
          ),
        ),
        PopupMenuItem(
          enabled: false,
          child: widgets.Button(
            label: "Champs",
            elevation: 4,
            onPressed: onPressChamps,
          ),
        ),
        const PopupMenuItem(
          enabled: false,
          height: 24,
          padding: EdgeInsets.zero,
          child: Center(child: Text("match actions")),
        ),
        const PopupMenuDivider(height: 10),
        PopupMenuItem(
          enabled: false,
          child: widgets.Button(
            label: "Filter",
            elevation: 0,
            onPressed: onFilter,
            color: Colors.pink,
          ),
        ),
      ],
    );
  }
}
