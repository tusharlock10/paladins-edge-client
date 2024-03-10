import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/widgets/index.dart" as widgets;

class FriendsAppBar extends ConsumerWidget {
  final bool isOtherPlayer;
  final RefreshCallback onRefresh;
  final bool isRefreshing;
  final String playerId;

  const FriendsAppBar({
    required this.isOtherPlayer,
    required this.onRefresh,
    required this.isRefreshing,
    required this.playerId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final playerNotifier = providers.players(playerId);
    final friendNotifier = providers.friends(playerId);
    final player = ref.watch(playerNotifier.select((_) => _.playerData));
    final friends = ref.watch(friendNotifier.select((_) => _.friends));
    final isLoadingFriends = ref.watch(
      friendNotifier.select((_) => _.isLoadingFriends),
    );

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
            isOtherPlayer && player != null ? player.name : "Friends",
          ),
          if (!isLoadingFriends && friends != null)
            Text(
              isOtherPlayer
                  ? "has ${friends.length} friends"
                  : "you have ${friends.length}",
              style: const TextStyle(fontSize: 12),
            ),
        ],
      ),
    );
  }
}
