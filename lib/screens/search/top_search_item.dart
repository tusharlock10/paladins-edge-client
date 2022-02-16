import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class TopSearchItem extends HookConsumerWidget {
  final models.Player player;

  const TopSearchItem({
    required this.player,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final playersProvider = ref.read(providers.players);

    // Methods
    final onTap = useCallback(
      () {
        playersProvider.setPlayerId(player.playerId);
        Navigator.of(context).pushNamed(screens.PlayerDetail.routeName);
      },
      [],
    );

    return ListTile(
      onTap: onTap,
      title: Text(
        player.name,
        style: Theme.of(context).primaryTextTheme.headline6,
      ),
      trailing: player.ranked != null
          ? widgets.FastImage(
              imageUrl: player.ranked!.rankIconUrl,
            )
          : const SizedBox(),
    );
  }
}
