import 'package:flutter/material.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/widgets/index.dart' as widgets;
import 'package:provider/provider.dart';

class PlayerDetail extends StatefulWidget {
  static const routeName = '/playerDetail';
  const PlayerDetail({Key? key}) : super(key: key);

  @override
  _PlayerDetailState createState() => _PlayerDetailState();
}

class _PlayerDetailState extends State<PlayerDetail> {
  bool _init = true;

  @override
  void deactivate() {
    Provider.of<providers.Search>(context, listen: false).clearPlayerData();
    super.deactivate();
  }

  @override
  void didChangeDependencies() {
    if (_init) {
      _init = false;
      // check if the playerId is passed in arguments
      // if passed set loading to true and fetch the
      // data from server using playerId else show the player
      // from the playerData in provider

      final playerId = ModalRoute.of(context)?.settings.arguments as String?;
      if (playerId != null) {
        // fetch data from server
        Provider.of<providers.Search>(context, listen: false)
            .getPlayerData(playerId);
      }
    }
    super.didChangeDependencies();
  }

  Widget buildLoading() {
    return const Center(
      child: widgets.LoadingIndicator(
        size: 36,
      ),
    );
  }

  Widget buildObserve() {
    final authProvider = Provider.of<providers.Auth>(context);
    final player = Provider.of<providers.Search>(context).playerData;
    final isObserving =
        authProvider.user?.observeList.contains(player?.playerId) == true;

    final textTheme = Theme.of(context).textTheme.headline6?.copyWith(
        fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white);
    final buttonColor = isObserving ? Colors.red : Colors.green;

    return ElevatedButton(
      onPressed: () => authProvider.observePlayer(player!.playerId),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(buttonColor),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
      child: Text(isObserving ? 'Stop Observing' : 'Start Observing',
          style: textTheme),
    );
  }

  Widget buildPlayerDetail(models.Player player) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: [
          Row(
            children: [
              widgets.ElevatedAvatar(
                size: 36,
                imageUrl: player.avatarUrl!,
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    player.name,
                    style: theme.textTheme.headline3?.copyWith(fontSize: 22),
                  ),
                  player.title != null
                      ? Text(
                          player.title!,
                          style:
                              theme.textTheme.bodyText1?.copyWith(fontSize: 14),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      player.ranked.rankIconUrl != null
                          ? widgets.FastImage(
                              imageUrl: player.ranked.rankIconUrl!,
                              height: 42,
                              width: 42,
                            )
                          : const SizedBox(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${player.ranked.rankName}',
                            style: theme.textTheme.bodyText2
                                ?.copyWith(fontSize: 11),
                          ),
                          Text(
                            '${player.ranked.points} TP',
                            style: theme.textTheme.bodyText1
                                ?.copyWith(fontSize: 11),
                          )
                        ],
                      )
                    ],
                  )
                ],
              )
            ],
          ),
          buildObserve(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final player = Provider.of<providers.Search>(context).playerData;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Player Details'),
      ),
      body: player == null ? buildLoading() : buildPlayerDetail(player),
    );
  }
}
