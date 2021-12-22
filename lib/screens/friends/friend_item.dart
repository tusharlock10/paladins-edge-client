import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class FriendItem extends ConsumerWidget {
  final models.Player friend;
  final void Function(models.Player) onSelectFriend;

  const FriendItem({
    required this.friend,
    required this.onSelectFriend,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final favouriteFriends =
        ref.watch(providers.auth.select((_) => _.user?.favouriteFriends));

    final bool isFavourite =
        favouriteFriends?.contains(friend.playerId) ?? false;

    return widgets.Ripple(
      onTap: () => onSelectFriend(friend),
      height: 80,
      child: Card(
        elevation: 7,
        child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Row(
            children: [
              friend.avatarUrl != null
                  ? widgets.ElevatedAvatar(
                      size: 24,
                      borderRadius: 5,
                      imageUrl: friend.avatarUrl!,
                    )
                  : const SizedBox(),
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
                      '${friend.platform}',
                      style: theme.textTheme.bodyText1?.copyWith(fontSize: 10),
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              friend.ranked.rank != 0 && friend.ranked.rankIconUrl != null
                  ? widgets.FastImage(
                      height: 36,
                      width: 36,
                      imageUrl: friend.ranked.rankIconUrl!,
                    )
                  : const SizedBox(),
              Container(
                color: isFavourite ? Colors.yellow : Colors.transparent,
                height: 80,
                width: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
