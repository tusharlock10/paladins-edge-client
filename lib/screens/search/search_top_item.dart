import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class SearchTopItem extends HookConsumerWidget {
  final models.Player player;

  const SearchTopItem({
    required this.player,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final playersProvider = ref.read(providers.players);

    // Variables
    final textTheme = Theme.of(context).textTheme;

    // Methods
    final onTap = useCallback(
      () {
        utilities.unFocusKeyboard(context);
        playersProvider.setPlayerId(player.playerId);
        Navigator.of(context).pushNamed(screens.PlayerDetail.routeName);
      },
      [],
    );

    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: widgets.ElevatedAvatar(
                      imageUrl: player.avatarUrl,
                      size: 24,
                      borderRadius: 3,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        player.name,
                        style: textTheme.headline6?.copyWith(fontSize: 16),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        player.region,
                        style: textTheme.bodyText1?.copyWith(fontSize: 14),
                      ),
                      Text(
                        player.platform,
                        style: textTheme.bodyText1?.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (player.ranked.rank != 0)
                    widgets.FastImage(
                      imageUrl: player.ranked.rankIconUrl,
                      height: 32,
                      width: 32,
                    ),
                  const SizedBox(height: 3),
                  Text(
                    Jiffy(player.lastLoginDate).fromNow(),
                    style: textTheme.bodyText1?.copyWith(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
