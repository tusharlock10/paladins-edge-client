import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MatchDetail extends HookConsumerWidget {
  static const routeName = '/matchDetail';

  const MatchDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matchId = ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Match Detail"),
      ),
      body: Text("MathcId : $matchId"),
    );
  }
}
