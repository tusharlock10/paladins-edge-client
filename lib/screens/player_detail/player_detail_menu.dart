import "package:badges/badges.dart";
import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/index.dart" as screens;
import "package:paladinsedge/screens/player_detail/player_detail_filter_modal.dart";
import "package:paladinsedge/theme/index.dart" as theme;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

class PlayerDetailMenu extends HookConsumerWidget {
  const PlayerDetailMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final playersProvider = ref.read(providers.players);
    final matchesProvider = ref.read(providers.matches);
    final selectedFilter =
        ref.watch(providers.matches.select((_) => _.selectedFilter));
    final selectedSort =
        ref.watch(providers.matches.select((_) => _.selectedSort));
    final player = ref.watch(providers.players.select((_) => _.playerData));
    final playerStatus = ref.watch(
      providers.players.select((_) => _.playerStatus),
    );

    // Variables
    final brightness = Theme.of(context).brightness;
    final isValidFilterAndSort = selectedFilter.isValid ||
        selectedSort != data_classes.MatchSort.defaultSort;

    // Hooks
    final badgeColor = useMemoized(
      () {
        return brightness == Brightness.light
            ? theme.themeMaterialColor.shade50
            : theme.themeMaterialColor;
      },
      [brightness],
    );

    // Methods
    final onPressActiveMatch = useCallback(
      () {
        if (player == null) return;

        utilities.Analytics.logEvent(
          constants.AnalyticsEvent.otherPlayerActiveMatch,
        );
        playersProvider.resetPlayerStatus();
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

        utilities.Analytics.logEvent(
          constants.AnalyticsEvent.otherPlayerFriends,
        );
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

        utilities.Analytics.logEvent(
          constants.AnalyticsEvent.otherPlayerChampions,
        );
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
        utilities.Analytics.logEvent(
          constants.AnalyticsEvent.playerMatchesFilterSort,
        );
        utilities.Navigation.pop(context);
        showPlayerDetailFilterModal(context);
      },
      [],
    );

    final onClear = useCallback(
      () {
        matchesProvider.clearAppliedFiltersAndSort();
        utilities.Navigation.pop(context);
      },
      [],
    );

    return PopupMenuButton(
      icon: Badge(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        elevation: 0,
        badgeColor: badgeColor,
        showBadge: isValidFilterAndSort,
        position: BadgePosition.topEnd(top: -4, end: -6),
        child: const Icon(
          FeatherIcons.moreVertical,
          color: Colors.white,
        ),
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
            disabled: !(playerStatus?.inMatch ?? false),
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
            label: "Filter / Sort",
            elevation: 4,
            onPressed: onFilter,
            color: Colors.pink,
          ),
        ),
        PopupMenuItem(
          enabled: false,
          child: widgets.Button(
            disabled: !isValidFilterAndSort,
            label: "Clear",
            elevation: 4,
            onPressed: onClear,
            color: Colors.pink,
          ),
        ),
      ],
    );
  }
}
