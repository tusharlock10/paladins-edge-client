import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class HomeFavouriteFriendItem extends HookConsumerWidget {
  final models.Player friend;
  const HomeFavouriteFriendItem({
    required this.friend,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final authProvider = ref.read(providers.auth);

    // Variables
    final textTheme = Theme.of(context).textTheme;

    // Methods
    final onPressFriend = useCallback(
      () {
        utilities.Navigation.navigate(
          context,
          screens.PlayerDetail.routeName,
          params: {
            'playerId': friend.playerId,
          },
        );
      },
      [friend],
    );

    final onFavouriteFriend = useCallback(
      () {
        authProvider.markFavouriteFriend(friend.playerId);
      },
      [friend],
    );

    final getLastSeen = useCallback(
      () {
        final lastLoginDate = friend.lastLoginDate;
        final duration = DateTime.now().difference(lastLoginDate);
        if (duration > const Duration(days: 1)) {
          return Jiffy(lastLoginDate).yMMMd;
        }

        return Jiffy(lastLoginDate).fromNow();
      },
      [friend],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        elevation: 7,
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LayoutBuilder(
                builder: (_, constraints) {
                  return widgets.ElevatedAvatar(
                    imageUrl: friend.avatarUrl,
                    imageBlurHash: friend.avatarBlurHash,
                    size: constraints.maxHeight / 2,
                    borderRadius: constraints.maxHeight / 3.5,
                  );
                },
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: onPressFriend,
                      child: Text(
                        friend.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.headline1?.copyWith(
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    if (friend.title != null)
                      Text(
                        friend.title!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyText1?.copyWith(fontSize: 12),
                      ),
                    const SizedBox(height: 5),
                    RichText(
                      text: TextSpan(
                        text: 'Last Seen: ',
                        style: textTheme.bodyText1?.copyWith(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                        children: [
                          TextSpan(
                            text: getLastSeen(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              widgets.IconButton(
                iconSize: 28,
                icon: Icons.star,
                color: Colors.yellow,
                onPressed: onFavouriteFriend,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
