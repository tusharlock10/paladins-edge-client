import "dart:math";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/search/search_lower_item.dart";

class SearchLowerList extends ConsumerWidget {
  const SearchLowerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lowerSearchList = ref.watch(
      providers.search.select((_) => _.lowerSearchList),
    );
    final childCount = min(lowerSearchList.length, 20);

    return SliverPadding(
      padding: const EdgeInsets.all(10),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          mainAxisExtent: 70,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return SearchLowerItem(
              lowerSearch: lowerSearchList[index],
            );
          },
          childCount: childCount,
        ),
      ),
    );
  }
}
