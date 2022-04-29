import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/providers/index.dart' as providers;

class FriendsAppBar extends ConsumerWidget {
  const FriendsAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final friends = ref.watch(providers.friends.select((_) => _.friends));
    final otherPlayerFriends =
        ref.watch(providers.friends.select((_) => _.otherPlayerFriends));
    final isLoadingFriends =
        ref.watch(providers.friends.select((_) => _.isLoadingFriends));
    final otherPlayer =
        ref.watch(providers.friends.select((_) => _.otherPlayer));

    // Variables
    final isOtherPlayer = otherPlayer != null;
    final data = isOtherPlayer ? otherPlayerFriends : friends;

    return SliverAppBar(
      snap: true,
      floating: true,
      forceElevated: true,
      pinned: constants.isWeb,
      title: Column(
        children: [
          Text(
            isOtherPlayer ? otherPlayer!.name : 'Friends',
          ),
          if (!isLoadingFriends && data != null)
            Text(
              isOtherPlayer
                  ? 'has ${data.length} friends'
                  : 'you have ${data.length}',
              style: const TextStyle(fontSize: 12),
            ),
        ],
      ),
    );
  }
}
