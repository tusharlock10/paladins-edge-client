import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/providers/index.dart' as providers;

class FriendsAppBar extends ConsumerWidget {
  const FriendsAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final friends = ref.watch(providers.players.select((_) => _.friends));
    final isLoadingFriends =
        ref.watch(providers.players.select((_) => _.isLoadingFriends));

    return SliverAppBar(
      snap: true,
      floating: true,
      forceElevated: true,
      title: Column(
        children: [
          const Text('Friends'),
          if (!isLoadingFriends)
            Text(
              'You have ${friends.length}',
              style: const TextStyle(fontSize: 12),
            ),
        ],
      ),
    );
  }
}
