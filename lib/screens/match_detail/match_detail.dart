import "package:dartx/dartx.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/index.dart" as screens;
import "package:paladinsedge/screens/match_detail/match_detail_app_bar.dart";
import "package:paladinsedge/screens/match_detail/match_detail_list.dart";

class MatchDetail extends HookConsumerWidget {
  static const routeName = "match";
  static const routePath = "match/:matchId";
  static const savedMatchRouteName = "saved-match";
  static const savedMatchRoutePath = "match/:matchId";
  static const commonMatchRouteName = "common-match";
  static const commonMatchRoutePath = "match/:matchId";
  static const topMatchRouteName = "top-match";
  static const topMatchRoutePath = "match/:matchId";

  const MatchDetail({
    required this.matchId,
    required this.isSavedMatch,
    Key? key,
  }) : super(key: key);

  static Page _routeBuilder(_, GoRouterState state) {
    final paramMatchId = int.tryParse(state.params["matchId"] ?? "");
    final isSavedMatch =
        (state.queryParams["isSavedMatch"] ?? "false") == "true";
    if (paramMatchId == null) {
      return const CupertinoPage(child: screens.NotFound());
    }

    return CupertinoPage(
      child: MatchDetail(
        matchId: paramMatchId,
        isSavedMatch: isSavedMatch,
      ),
    );
  }

  final int matchId;
  final bool isSavedMatch;
  static final topMatchGoRoute = GoRoute(
    name: topMatchRouteName,
    path: topMatchRoutePath,
    pageBuilder: _routeBuilder,
  );
  static final commonMatchGoRoute = GoRoute(
    name: commonMatchRouteName,
    path: commonMatchRoutePath,
    pageBuilder: _routeBuilder,
  );
  static final savedMatchGoRoute = GoRoute(
    name: savedMatchRouteName,
    path: savedMatchRoutePath,
    pageBuilder: _routeBuilder,
  );
  static final goRoute = GoRoute(
    name: routeName,
    path: routePath,
    pageBuilder: _routeBuilder,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final savedMatches =
        isSavedMatch ? ref.read(providers.matches).savedMatches : null;
    final matchDetails = !isSavedMatch
        ? ref.watch(providers.matches.select((_) => _.matchDetails))
        : null;

    // Hooks
    final combinedMatch = useMemoized(
      () {
        if (!isSavedMatch && matchDetails != null) {
          return data_classes.CombinedMatch(
            match: matchDetails.match,
            matchPlayers: matchDetails.matchPlayers,
          );
        }

        final combinedMatch = savedMatches?.firstOrNullWhere(
          (_) => _.match.matchId == matchId,
        );

        if (combinedMatch == null) return null;

        return combinedMatch.copyWith(
          matchPlayers: combinedMatch.matchPlayers.sortedBy((a) => a.team),
        );
      },
      [isSavedMatch, savedMatches, matchDetails],
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          MatchDetailAppBar(combinedMatch: combinedMatch),
          MatchDetailList(
            matchId: matchId,
            combinedMatch: combinedMatch,
            isSavedMatch: isSavedMatch,
          ),
        ],
      ),
    );
  }
}
