import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class FriendItem extends HookConsumerWidget {
  final bool isSelected;
  final models.Player friend;
  final void Function()? onPressFriend;
  final void Function()? onPressFriendName;
  final void Function()? onFavouriteFriend;

  // TODO: Refactor friends to use hooks in FriendsItem, instead of using callbacks
  const FriendItem({
    required this.isSelected,
    required this.friend,
    required this.onPressFriend,
    required this.onPressFriendName,
    required this.onFavouriteFriend,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final favouriteFriends =
        ref.watch(providers.auth.select((_) => _.user?.favouriteFriends));

    // Variables
    const double itemHeight = 85;
    final theme = Theme.of(context);
    final bool isFavourite =
        favouriteFriends?.contains(friend.playerId) ?? false;

    return widgets.InteractiveCard(
      elevation: 7,
      borderRadius: 10,
      onTap: onPressFriend,
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
                  GestureDetector(
                    onTap: onPressFriendName,
                    child: Text(
                      friend.name,
                      style: theme.textTheme.headline3?.copyWith(
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  friend.title != null
                      ? Text(
                          '${friend.title}',
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
            !isSelected
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
