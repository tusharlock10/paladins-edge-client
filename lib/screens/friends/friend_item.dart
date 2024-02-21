import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/constants/index.dart" as constants;
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

  static const itemHeight = 96.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final authProvider = ref.read(providers.auth);
    final baseRanks = ref.read(providers.baseRanks).baseRanks;
    final favouriteFriends = ref.watch(
      providers.auth.select((_) => _.user?.favouriteFriends),
    );

    // Variables
    final theme = Theme.of(context);
    final bool isFavourite = isOtherPlayer
        ? false
        : favouriteFriends?.contains(friend.playerId) ?? false;

    // State
    final isSelected = useState(false);

    // Hooks
    final friendBaseRank = useMemoized(
      () => baseRanks[friend.ranked.rank],
      [friend, baseRanks],
    );

    final rankIcon = useMemoized(
      () {
        if (friendBaseRank == null) return null;

        var rankIcon = data_classes.PlatformOptimizedImage(
          imageUrl: utilities.getSmallAsset(friendBaseRank.rankIconUrl),
          isAssetImage: false,
        );
        if (!constants.isWeb) {
          final assetUrl = utilities.getAssetImageUrl(
            constants.ChampionAssetType.ranks,
            friendBaseRank.rank,
          );
          if (assetUrl != null) {
            rankIcon.imageUrl = assetUrl;
            rankIcon.isAssetImage = true;
          }
        }

        return rankIcon;
      },
      [friendBaseRank],
    );

    // Methods
    final onTapFriend = useCallback(
      () {
        if (!isOtherPlayer) {
          isSelected.value = !isSelected.value;
        }
      },
      [isOtherPlayer, isSelected.value],
    );

    final onFavouriteFriendFail = useCallback(
      (String error) {
        widgets.showToast(
          context: context,
          text: error,
          type: widgets.ToastType.info,
        );
      },
      [],
    );

    final onFavouriteFriend = useCallback(
      () async {
        if (isOtherPlayer) return;

        final result = await authProvider.markFavouriteFriend(friend.playerId);

        if (result == data_classes.FavouriteFriendResult.limitReached) {
          // user already has max number of friends
          // show a toast displaying this info
          final error =
              "You cannot have more than ${utilities.Global.essentials!.maxFavouriteFriends} favourite friends";
          onFavouriteFriendFail(error);
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

    return SizedBox(
      height: FriendItem.itemHeight,
      child: widgets.InteractiveCard(
        elevation: 7,
        borderRadius: 10,
        onTap: onTapFriend,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        child: Row(
          children: [
            widgets.ElevatedAvatar(
              imageUrl: friend.avatarUrl,
              imageBlurHash: friend.avatarBlurHash,
              size: 34,
              borderRadius: 5,
            ),
            const SizedBox(width: 5),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText(
                  friend.name,
                  onTap: onPressFriendName,
                  style: theme.textTheme.displayLarge?.copyWith(
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const SizedBox(height: 5),
                friend.title != null
                    ? Text(
                        "${friend.title}",
                        style:
                            theme.textTheme.bodyMedium?.copyWith(fontSize: 12),
                      )
                    : const SizedBox(),
                Text(
                  "${friend.platform} | ${friend.region}",
                  style: theme.textTheme.bodyLarge?.copyWith(fontSize: 10),
                ),
              ],
            ),
            const Expanded(
              child: SizedBox(),
            ),
            rankIcon != null
                ? widgets.FastImage(
                    imageUrl: rankIcon.imageUrl,
                    isAssetImage: rankIcon.isAssetImage,
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
                      child: widgets.FavouriteStar(
                        isFavourite: isFavourite,
                        size: 28,
                        onPress: onFavouriteFriend,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
