import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/index.dart" as screens;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

class FriendItem extends HookConsumerWidget {
  final bool isOtherPlayer;
  final models.Player friend;

  const FriendItem({
    required this.isOtherPlayer,
    required this.friend,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final authProvider = ref.read(providers.auth);
    final favouriteFriends =
        ref.watch(providers.auth.select((_) => _.user?.favouriteFriends));

    // Variables
    const double itemHeight = 85;
    final theme = Theme.of(context);
    final bool isFavourite =
        favouriteFriends?.contains(friend.playerId) ?? false;

    // State
    final isSelected = useState(false);

    // Methods
    final onFavouriteFriend = useCallback(
      () async {
        if (isOtherPlayer) return;

        final result = await authProvider.markFavouriteFriend(friend.playerId);

        if (result == data_classes.FavouriteFriendResult.limitReached) {
          // user already has max number of friends
          // show a toast displaying this info

          widgets.showToast(
            context: context,
            text:
                "You cannot have more than ${utilities.Global.essentials!.maxFavouriteFriends} favourite friends",
            type: widgets.ToastType.info,
          );
        }
      },
      [isOtherPlayer, friend],
    );

    final onPressFriendName = useCallback(
      () {
        utilities.Navigation.navigate(
          context,
          screens.PlayerDetail.routeName,
          params: {
            "playerId": friend.playerId,
          },
        );
      },
      [friend],
    );

    return widgets.InteractiveCard(
      elevation: 7,
      borderRadius: 10,
      onTap: () => isSelected.value = !isSelected.value,
      padding: const EdgeInsets.only(left: 10),
      child: SizedBox(
        height: itemHeight,
        child: Row(
          children: [
            widgets.ElevatedAvatar(
              imageUrl: friend.avatarUrl,
              imageBlurHash: friend.avatarBlurHash,
              size: 32,
              borderRadius: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(
                    friend.name,
                    onTap: onPressFriendName,
                    style: theme.textTheme.headline3?.copyWith(
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  friend.title != null
                      ? Text(
                          "${friend.title}",
                          style:
                              theme.textTheme.bodyText2?.copyWith(fontSize: 12),
                        )
                      : const SizedBox(),
                  Text(
                    friend.platform,
                    style: theme.textTheme.bodyText1?.copyWith(fontSize: 10),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            friend.ranked.rank != 0
                ? widgets.FastImage(
                    imageUrl: utilities.getSmallAsset(
                      friend.ranked.rankIconUrl,
                    ),
                    height: 36,
                    width: 36,
                  )
                : const SizedBox(),
            const SizedBox(width: 10),
            !isSelected.value
                ? Container(
                    color: isFavourite ? Colors.yellow : Colors.transparent,
                    height: itemHeight,
                    width: 10,
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 5, right: 5),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        iconSize: 28,
                        onPressed: onFavouriteFriend,
                        icon: Icon(
                          isFavourite
                              ? Icons.star
                              : Icons.star_outline_outlined,
                          color: isFavourite
                              ? Colors.yellow
                              : theme.textTheme.bodyText1?.color,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
