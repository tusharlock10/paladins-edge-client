import 'package:flutter/material.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class TopSearchItem extends StatelessWidget {
  final models.Player player;

  const TopSearchItem({
    required this.player,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.pushNamed(
        context,
        screens.PlayerDetail.routeName,
        arguments: player.playerId,
      ),
      title: Text(
        player.name,
        style: Theme.of(context).primaryTextTheme.headline6,
      ),
      trailing: widgets.FastImage(
        imageUrl: player.ranked.rankIconUrl,
      ),
    );
  }
}
