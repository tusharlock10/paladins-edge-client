import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/search/lower_search_item.dart';
import 'package:paladinsedge/screens/search/top_search_item.dart';

class SearchList extends ConsumerWidget {
  const SearchList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchProvider = ref.watch(providers.players);
    final topSearchList = searchProvider.topSearchList;
    final lowerSearchList = searchProvider.lowerSearchList;
    final childCount = topSearchList.length + lowerSearchList.length;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index < topSearchList.length) {
            return TopSearchItem(player: topSearchList[index]);
          } else {
            return LowerSearchItem(
              lowerSearch: lowerSearchList[index - topSearchList.length],
            );
          }
        },
        childCount: childCount,
      ),
    );
  }
}
