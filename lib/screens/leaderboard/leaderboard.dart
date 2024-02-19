import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/providers/index.dart" as providers;
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
    double horizontalPadding = 0;
    double? width;
    final size = MediaQuery.of(context).size;
    if (size.height < size.width) {
      // for landscape mode
      width = size.width * 0.65;
      horizontalPadding = (size.width - width) / 2;
    }

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

    // Hooks
    final rankItems = useMemoized(
      () => validRanks
          .map(
            (baseRank) => DropdownMenuItem(
              value: baseRank.rank,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    widgets.FastImage(
                      imageUrl: utilities.getSmallAsset(
                        baseRank.rankIconUrl,
                      ),
                      height: 22,
                      width: 22,
                    ),
                    const SizedBox(width: 5),
                    Text(baseRank.rankName),
                  ],
                ),
              ),
            ),
          )
          .toList(),
      [validRanks],
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
          const SliverAppBar(
            forceElevated: true,
            floating: true,
            snap: true,
            pinned: constants.isWeb,
            title: Text("Leaderboard"),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: Theme(
                data: theme.copyWith(canvasColor: theme.cardTheme.color),
                child: DropdownButton<int>(
                  menuMaxHeight: 420,
                  items: rankItems,
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
          ),
          isLoading || leaderboardPlayers == null
              ? SliverList(
                  delegate: SliverChildListDelegate.fixed(
                    [
                      SizedBox(
                        height: utilities.getBodyHeight(context),
                        child: const Center(
                          child: widgets.LoadingIndicator(
                            lineWidth: 2,
                            size: 28,
                            label: Text("Getting Players"),
                          ),
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
                  sliver: SliverList(
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
