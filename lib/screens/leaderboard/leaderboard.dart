import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/providers/index.dart" as providers;
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
    final leaderboardProvider = ref.read(providers.leaderboard);
    final leaderboardPlayers = ref.watch(
      providers.leaderboard.select((_) => _.leaderboardPlayers),
    );

    // Variables
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
        if (leaderboardPlayers == null) {
          leaderboardProvider.getLeaderboardPlayers();
        }

        return;
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
          leaderboardPlayers == null
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
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (_, index) =>
                          Text(leaderboardPlayers[index].basicPlayer.name),
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
