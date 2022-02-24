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
    // Providers
    final searchProvider = ref.watch(providers.players);

    // Variables
    final textTheme = Theme.of(context).textTheme;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final search = searchProvider.searchHistory[index];

          return ListTile(
            onTap: () => onTap(search.playerName),
            title: Text(
              search.playerName,
              style: textTheme.headline6?.copyWith(fontSize: 16),
            ),
            trailing: TimerBuilder.periodic(
              const Duration(minutes: 1),
              builder: (context) {
                return Text(
                  Jiffy(search.time).fromNow(),
                  style: textTheme.bodyText1?.copyWith(fontSize: 12),
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
