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

  const CommonMatches({
    required this.playerId,
    Key? key,
  }) : super(key: key);

  static Page _routeBuilder(_, GoRouterState state) {
    final paramPlayerId = int.tryParse(state.params["playerId"] ?? "");
    if (paramPlayerId == null) {
      return const CupertinoPage(child: screens.NotFound());
    }

    return CupertinoPage(child: CommonMatches(playerId: paramPlayerId));
  }

  static GoRoute goRouteBuilder(List<GoRoute> routes) => GoRoute(
        name: routeName,
        path: routePath,
        pageBuilder: _routeBuilder,
        routes: routes,
        redirect: utilities.Navigation.protectedRouteRedirect,
      );

  final int playerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final matchesProvider = ref.read(providers.matches);
    final userPlayerId = ref.watch(
      providers.auth.select((_) => _.player?.playerId),
    );
    final isCommonMatchesLoading = ref.watch(
      providers.matches.select((_) => _.isCommonMatchesLoading),
    );
    final commonMatchesPlayerId = ref.watch(
      providers.matches.select((_) => _.commonMatchesPlayerId),
    );
    final commonMatches = ref.watch(
      providers.matches.select((_) => _.commonMatches),
    );

    // Variables
    final hideList = commonMatches == null ||
        commonMatches.isEmpty ||
        isCommonMatchesLoading;

    // Effects
    useEffect(
      () {
        if (userPlayerId != null && playerId != commonMatchesPlayerId) {
          matchesProvider.getCommonMatches(
            userPlayerId: userPlayerId,
            playerId: playerId,
          );
        }

        return;
      },
      [commonMatchesPlayerId, playerId],
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            forceElevated: true,
            floating: true,
            snap: true,
            pinned: constants.isWeb,
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
          if (!hideList) const CommonMatchesHeader(),
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
}
