import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/widgets/index.dart" as widgets;

class FriendsAppBar extends ConsumerWidget {
  final bool isOtherPlayer;
  final RefreshCallback onRefresh;
  final bool isRefreshing;

  const FriendsAppBar({
    required this.isOtherPlayer,
    required this.onRefresh,
    required this.isRefreshing,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final friends = ref.watch(providers.friends.select((_) => _.friends));
    final otherPlayerFriends =
        ref.watch(providers.friends.select((_) => _.otherPlayerFriends));
    final isLoadingFriends =
        ref.watch(providers.friends.select((_) => _.isLoadingFriends));
    final otherPlayer =
        ref.watch(providers.players.select((_) => _.playerData));

    // Variables
    final data = isOtherPlayer ? otherPlayerFriends : friends;

    return SliverAppBar(
      snap: true,
      floating: true,
      forceElevated: true,
      pinned: !constants.isMobile,
      actions: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: widgets.RefreshButton(
              color: Colors.white,
              onRefresh: onRefresh,
              isRefreshing: isRefreshing,
            ),
          ),
        ),
      ],
      title: Column(
        children: [
          Text(
            isOtherPlayer ? otherPlayer!.name : "Friends",
          ),
          if (!isLoadingFriends && data != null)
            Text(
              isOtherPlayer
                  ? "has ${data.length} friends"
                  : "you have ${data.length}",
              style: const TextStyle(fontSize: 12),
            ),
        ],
      ),
    );
  }
}
