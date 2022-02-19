import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/search/top_search_item.dart';

class TopSearchList extends ConsumerWidget {
  const TopSearchList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchProvider = ref.watch(providers.players);
    final topSearchList = searchProvider.topSearchList;
    final childCount = topSearchList.length;

    return SliverPadding(
      padding: const EdgeInsets.all(10),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return TopSearchItem(player: topSearchList[index]);
          },
          childCount: childCount,
        ),
      ),
    );
  }
}
