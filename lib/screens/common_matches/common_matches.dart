import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/common_matches/common_matches_header.dart";
import "package:paladinsedge/screens/common_matches/common_matches_list.dart";
import "package:paladinsedge/screens/index.dart" as screens;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

class CommonMatches extends HookConsumerWidget {
  static const routeName = "common-matches";
  static const routePath = "common-matches";
  final String playerId;

  const CommonMatches({
    required this.playerId,
    Key? key,
  }) : super(key: key);

  static GoRoute goRouteBuilder(List<GoRoute> routes) => GoRoute(
        name: routeName,
        path: routePath,
        pageBuilder: _routeBuilder,
        routes: routes,
        redirect: utilities.Navigation.protectedRouteRedirect,
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final playerNotifier = providers.players(playerId);
    final playerProvider = ref.read(playerNotifier);
    final isCommonMatchesLoading = ref.watch(
      playerNotifier.select((_) => _.isCommonMatchesLoading),
    );
    final commonMatches = ref.watch(
      playerNotifier.select((_) => _.commonMatches),
    );

    // Variables
    final hideList = commonMatches == null ||
        commonMatches.isEmpty ||
        isCommonMatchesLoading;

    // Effects
    useEffect(
      () {
        playerProvider.getCommonMatches();

        return;
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
            pinned: !constants.isMobile,
            title: commonMatches != null && commonMatches.isNotEmpty
                ? Column(
                    children: [
                      const Text("You both have"),
                      Text(
                        "${commonMatches.length} matches in common",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  )
                : const Text("Common Matches"),
          ),
          if (!hideList) CommonMatchesHeader(playerId: playerId),
          hideList
              ? SliverList(
                  delegate: SliverChildListDelegate.fixed(
                    [
                      SizedBox(
                        height: utilities.getBodyHeight(context),
                        child: Center(
                          child: commonMatches == null || isCommonMatchesLoading
                              ? const widgets.LoadingIndicator(
                                  lineWidth: 2,
                                  size: 28,
                                  label: Text("Getting Matches"),
                                )
                              : const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 40),
                                  child: Text(
                                    "You have not played any matches with this player",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                )
              : CommonMatchesList(playerId: playerId),
        ],
      ),
    );
  }

  static Page _routeBuilder(_, GoRouterState state) {
    final paramPlayerId = state.pathParameters["playerId"];
    if (paramPlayerId == null) {
      return const CupertinoPage(child: screens.NotFound());
    }

    if (int.tryParse(paramPlayerId) == null) {
      return const CupertinoPage(child: screens.NotFound());
    }
    final playerId = paramPlayerId;

    return CupertinoPage(
      child: widgets.PopShortcut(child: CommonMatches(playerId: playerId)),
    );
  }
}
