import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:paladinsedge/screens/match_detail/match_detail_app_bar.dart';
import 'package:paladinsedge/screens/match_detail/match_detail_list.dart';

class MatchDetail extends StatelessWidget {
  static const routeName = 'matchDetail';
  static const routePath = 'matchDetail';
  static final goRoute = GoRoute(
    name: routeName,
    path: routePath,
    builder: _routeBuilder,
  );

  const MatchDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          MatchDetailAppBar(),
          MatchDetailList(),
        ],
      ),
    );
  }

  static MatchDetail _routeBuilder(_, __) => const MatchDetail();
}
