import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/leaderboard/leaderboard_dropdown_item.dart";
import "package:paladinsedge/screens/leaderboard/leaderboard_player.dart";
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

class Leaderboard extends HookConsumerWidget {
  static const routeName = "leaderboard";
  static const routePath = "leaderboard";
  static final goRoute = GoRoute(
    name: routeName,
    path: routePath,
    pageBuilder: _routeBuilder,
  );

  const Leaderboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final validRanks = ref.read(providers.baseRanks).validRanks;
    final leaderboardProvider = ref.read(providers.leaderboard);
    final selectedRank = ref.watch(
      providers.leaderboard.select((_) => _.selectedRank),
    );
    final isLoading = ref.watch(
      providers.leaderboard.select((_) => _.isLoading),
    );
    final leaderboardPlayers = ref.watch(
      providers.leaderboard.select((_) => _.leaderboardPlayers),
    );

    // Variables
    final theme = Theme.of(context);
    int crossAxisCount;
    double horizontalPadding;
    double width;
    final size = MediaQuery.of(context).size;
    if (size.height < size.width) {
      // for landscape mode
      crossAxisCount = 2;
      width = size.width * 0.9;
      horizontalPadding = (size.width - width) / 2;
    } else {
      // for portrait mode
      crossAxisCount = 1;
      width = size.width;
      horizontalPadding = 15;
    }
    final itemWidth = width / crossAxisCount;
    double childAspectRatio = itemWidth / LeaderboardPlayer.itemHeight;

    // Effects
    useEffect(
      () {
        leaderboardProvider.loadSelectedRank();

        return null;
      },
      [],
    );

    useEffect(
      () {
        leaderboardProvider.getLeaderboardPlayers();

        return null;
      },
      [selectedRank],
    );

    // Methods
    final onSelectRank = useCallback(
      (int? rank) {
        if (rank != null) {
          leaderboardProvider.setSelectedRank(rank);
        }
      },
      [],
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            forceElevated: true,
            floating: true,
            snap: true,
            pinned: constants.isWeb,
            title: const Text("Leaderboard"),
            centerTitle: false,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Theme(
                  data: theme.copyWith(canvasColor: theme.cardTheme.color),
                  child: DropdownButton<int>(
                    underline: const SizedBox(),
                    menuMaxHeight: 420,
                    items: validRanks
                        .map(
                          (baseRank) => DropdownMenuItem(
                            value: baseRank.rank,
                            child: LeaderboardDropdownItem(baseRank: baseRank),
                          ),
                        )
                        .toList(),
                    onChanged: onSelectRank,
                    value: selectedRank,
                    iconEnabledColor: theme.textTheme.headlineMedium?.color,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    alignment: Alignment.center,
                    style: theme.textTheme.displayLarge?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ],
          ),
          isLoading || leaderboardPlayers == null
              ? SliverList(
                  delegate: SliverChildListDelegate.fixed(
                    [
                      SizedBox(
                        height: utilities.getBodyHeight(context),
                        child: Center(
                          child: isLoading
                              ? const widgets.LoadingIndicator(
                                  lineWidth: 2,
                                  size: 28,
                                  label: Text("Getting Players"),
                                )
                              : const Text("Unable to load leaderboard data"),
                        ),
                      ),
                    ],
                  ),
                )
              : SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: 5,
                  ),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      childAspectRatio: childAspectRatio,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (_, index) => LeaderboardPlayer(
                        leaderboardPlayer: leaderboardPlayers[index],
                      ),
                      childCount: leaderboardPlayers.length,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  static Page _routeBuilder(_, __) => const CupertinoPage(child: Leaderboard());
}
