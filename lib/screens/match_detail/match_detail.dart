import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:paladinsedge/screens/index.dart" as screens;
import "package:paladinsedge/screens/match_detail/match_detail_app_bar.dart";
import "package:paladinsedge/screens/match_detail/match_detail_list.dart";

class MatchDetail extends StatelessWidget {
  static const routeName = "match";
  static const routePath = "match/:matchId";
  static final goRoute = GoRoute(
    name: routeName,
    path: routePath,
    builder: _routeBuilder,
  );
  final String matchId;

  const MatchDetail({
    required this.matchId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const MatchDetailAppBar(),
          MatchDetailList(matchId: matchId),
        ],
      ),
    );
  }

  static Widget _routeBuilder(_, GoRouterState state) {
    final paramMatchId = state.params["matchId"];
    if (paramMatchId == null) {
      return const screens.NotFound();
    }

    if (int.tryParse(paramMatchId) == null) return const screens.NotFound();
    final matchId = paramMatchId;

    return MatchDetail(matchId: matchId);
  }
}
