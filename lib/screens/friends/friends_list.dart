import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/friends/friend_item.dart";
import "package:paladinsedge/utilities/index.dart" as utilities;

class FriendsList extends ConsumerWidget {
  final bool isOtherPlayer;

  const FriendsList({
    required this.isOtherPlayer,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final friends = ref.watch(providers.friends.select((_) => _.friends));
    final otherPlayerFriends =
        ref.watch(providers.friends.select((_) => _.otherPlayerFriends));

    // Variables
    int crossAxisCount;
    double horizontalPadding;
    double width;
    final size = MediaQuery.of(context).size;
    const itemHeight = 90.0;
    final data = isOtherPlayer ? otherPlayerFriends : friends;
    if (size.height < size.width) {
      // for landscape mode
      crossAxisCount = 2;
      width = size.width * 0.75;
      horizontalPadding = (size.width - width) / 2;
    } else {
      // for portrait mode
      crossAxisCount = 1;
      width = size.width;
      horizontalPadding = 15;
    }
    final itemWidth = width / crossAxisCount;
    double childAspectRatio = itemWidth / itemHeight;

    return data == null
        ? SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                SizedBox(
                  height: utilities.getBodyHeight(context),
                  child: Center(
                    child: Center(
                      child: Text(
                        isOtherPlayer
                            ? "Sorry we were unable to fetch friends of this player"
                            : "Sorry we were unable to fetch your friends",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: horizontalPadding,
            ),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: childAspectRatio,
                // mainAxisSpacing: 5,
              ),
              delegate: SliverChildBuilderDelegate(
                (_, index) {
                  final friend = data[index];

                  return FriendItem(
                    isOtherPlayer: isOtherPlayer,
                    friend: friend,
                  );
                },
                childCount: data.length,
              ),
            ),
          );
  }
}
