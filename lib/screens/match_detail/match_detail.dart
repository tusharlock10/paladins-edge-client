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
  static final goRoute = GoRoute(
    name: routeName,
    path: routePath,
    pageBuilder: _routeBuilder,
  );
  static const savedMatchRouteName = "saved-match";
  static const savedMatchRoutePath = "match/:matchId";
  static final savedMatchGoRoute = GoRoute(
    name: savedMatchRouteName,
    path: savedMatchRoutePath,
    pageBuilder: _routeBuilder,
  );
  static const commonMatchRouteName = "common-match";
  static const commonMatchRoutePath = "match/:matchId";
  static final commonMatchGoRoute = GoRoute(
    name: commonMatchRouteName,
    path: commonMatchRoutePath,
    pageBuilder: _routeBuilder,
  );
  static const topMatchRouteName = "top-match";
  static const topMatchRoutePath = "match/:matchId";
  static final topMatchGoRoute = GoRoute(
    name: topMatchRouteName,
    path: topMatchRoutePath,
    pageBuilder: _routeBuilder,
  );
  final String matchId;
  final bool isSavedMatch;

  const MatchDetail({
    required this.matchId,
    required this.isSavedMatch,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final savedMatches =
        isSavedMatch ? ref.read(providers.auth).savedMatches : null;
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

  static Page _routeBuilder(_, GoRouterState state) {
    final paramMatchId = state.pathParameters["matchId"];
    final isSavedMatch =
        (state.uri.queryParameters["isSavedMatch"] ?? "false") == "true";
    if (paramMatchId == null) {
      return const CupertinoPage(child: screens.NotFound());
    }

    if (int.tryParse(paramMatchId) == null) {
      return const CupertinoPage(child: screens.NotFound());
    }
    final matchId = paramMatchId;

    return CupertinoPage(
      child: MatchDetail(
        matchId: matchId,
        isSavedMatch: isSavedMatch,
      ),
    );
  }
}
