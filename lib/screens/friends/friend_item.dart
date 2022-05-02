import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class FriendItem extends ConsumerWidget {
  final models.Player friend;
  final void Function()? onSelectFriend;

  const FriendItem({
    required this.friend,
    required this.onSelectFriend,
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

    return Card(
      elevation: 7,
      margin: const EdgeInsets.only(top: 5, bottom: 10),
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: widgets.Ripple(
        onTap: onSelectFriend,
        height: itemHeight,
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
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
                    Text(
                      friend.name,
                      style: theme.textTheme.headline3?.copyWith(fontSize: 16),
                    ),
                    friend.title != null
                        ? Text(
                            '${friend.title}',
                            style: theme.textTheme.bodyText2
                                ?.copyWith(fontSize: 12),
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
                      imageUrl: friend.ranked.rankIconUrl,
                      imageBlurHash: friend.ranked.rankIconBlurHash,
                      height: 36,
                      width: 36,
                    )
                  : const SizedBox(),
              const SizedBox(width: 10),
              Container(
                color: isFavourite ? Colors.yellow : Colors.transparent,
                height: itemHeight,
                width: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
