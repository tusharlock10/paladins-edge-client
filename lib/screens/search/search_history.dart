import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:timer_builder/timer_builder.dart';

class SearchHistory extends ConsumerWidget {
  final String playerName;
  final void Function(String) onTap;

  const SearchHistory({
    required this.playerName,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchProvider = ref.watch(providers.players);

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final search = searchProvider.searchHistory[index];

          return ListTile(
            onTap: () => onTap(search.playerName),
            title: Text(
              search.playerName,
              style: Theme.of(context).primaryTextTheme.headline6,
            ),
            trailing: TimerBuilder.periodic(
              const Duration(minutes: 1),
              builder: (context) {
                return Text(
                  Jiffy(search.date).fromNow(),
                  style: Theme.of(context).primaryTextTheme.caption,
                );
              },
            ),
          );
        },
        childCount: searchProvider.searchHistory.length,
      ),
    );
  }
}
