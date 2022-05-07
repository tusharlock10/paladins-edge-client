import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:paladinsedge/screens/match_detail/match_detail_app_bar.dart';
import 'package:paladinsedge/screens/match_detail/match_detail_list.dart';

class MatchDetail extends StatelessWidget {
  static const routeName = '/matchDetail';

  const MatchDetail({Key? key}) : super(key: key);

  static BeamPage routeBuilder(BuildContext _, BeamState __, Object? ___) =>
      const BeamPage(title: 'Match • Paladins Edge', child: MatchDetail());

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
}
