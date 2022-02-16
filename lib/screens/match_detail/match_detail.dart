import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/screens/match_detail/match_detail_list.dart';

class MatchDetail extends HookConsumerWidget {
  static const routeName = '/matchDetail';

  const MatchDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Match Detail"),
      ),
      body: const MatchDetailList(),
    );
  }
}
