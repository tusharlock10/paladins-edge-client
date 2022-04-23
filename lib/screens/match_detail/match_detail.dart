import 'package:flutter/material.dart';
import 'package:paladinsedge/screens/match_detail/match_detail_app_bar.dart';
import 'package:paladinsedge/screens/match_detail/match_detail_list.dart';

class MatchDetail extends StatelessWidget {
  static const routeName = '/matchDetail';

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
}
