import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/search/search_top_item.dart";

class SearchTopList extends ConsumerWidget {
  const SearchTopList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topSearchList = ref.watch(
      providers.search.select((_) => _.topSearchList),
    );
    final childCount = topSearchList.length;

    return SliverPadding(
      padding: const EdgeInsets.all(10),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return SearchTopItem(player: topSearchList[index]);
          },
          childCount: childCount,
        ),
      ),
    );
  }
}
