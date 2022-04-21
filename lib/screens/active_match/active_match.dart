import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/data_classes/index.dart' as data_classes;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/active_match/active_match_player.dart';
import 'package:paladinsedge/widgets/index.dart' as widgets;

class ActiveMatch extends HookConsumerWidget {
  static const routeName = '/activeMatch';

  const ActiveMatch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final playersProvider = ref.read(providers.players);
    final championsProvider = ref.read(providers.champions);
    final authProvider = ref.read(providers.auth);
    final playerStatus =
        ref.watch(providers.players.select((_) => _.playerStatus));
    final playerStatusPlayerId =
        ref.watch(providers.players.select((_) => _.playerStatusPlayerId));

    // Variables
    final isUserPlayer = authProvider.player?.playerId == playerStatusPlayerId;
    final playersInfoTeam1 =
        playerStatus?.match?.playersInfo.where((_) => _.team == 1);
    final playersInfoTeam2 =
        playerStatus?.match?.playersInfo.where((_) => _.team == 2);

    // State
    final isLoading = useState(true);

    // Effects
    useEffect(
      () {
        if (playerStatusPlayerId != null) {
          playersProvider
              .getPlayerStatus(playerStatusPlayerId)
              .then((_) => isLoading.value = false);
        }

        return null;
      },
      [],
    );

    useEffect(
      () {
        if (playerStatus != null &&
            playerStatus.match != null &&
            playerStatus.match?.playersInfo != null) {
          final playerChampionsQuery =
              playerStatus.match!.playersInfo.map((item) {
            return data_classes.BatchPlayerChampionsPayload(
              championId: item.championId,
              playerId: item.player.playerId,
            );
          }).toList();

          championsProvider.getPlayerChampionsBatch(playerChampionsQuery);
        }

        return null;
      },
      [playerStatus],
    );

    // Methods
    final onRefresh = useCallback(
      () async {
        if (playerStatusPlayerId != null) {
          return playersProvider.getPlayerStatus(playerStatusPlayerId);
        }
      },
      [],
    );

    // TODO: Add floating SliverAppBar like in Home screen
    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Match'),
      ),
      body: isLoading.value
          ? const widgets.LoadingIndicator(
              lineWidth: 2,
              size: 28,
              label: Text('Loading Active Match'),
              center: true,
            )
          : playerStatus == null
              ? Center(
                  child: Text(
                    'Unable to fetch ${isUserPlayer ? "your" : "player"} active match',
                  ),
                )
              : widgets.Refresh(
                  onRefresh: onRefresh,
                  child: playerStatus.match == null
                      ? LayoutBuilder(
                          builder: (context, constraints) {
                            return ListView(
                              children: [
                                SizedBox(
                                  height: constraints.maxHeight,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        playerStatus.status,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${isUserPlayer ? "You are" : "Player is"} currently not in a match',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        )
                      : ListView(
                          children: [
                            const SizedBox(height: 30),
                            if (playerStatus.match != null)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    playerStatus.status,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${playerStatus.match?.map}',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            const SizedBox(height: 10),
                            const Center(
                              child: Text(
                                'Team 1',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            const SizedBox(height: 10),
                            ...playersInfoTeam1?.map(
                                  (_playerInfo) {
                                    return ActiveMatchPlayer(
                                      playerInfo: _playerInfo,
                                    );
                                  },
                                ).toList() ??
                                [],
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  'Team 2',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                            ...playersInfoTeam2?.map(
                                  (_playerInfo) {
                                    return ActiveMatchPlayer(
                                      playerInfo: _playerInfo,
                                    );
                                  },
                                ).toList() ??
                                [],
                            const SizedBox(height: 30),
                          ],
                        ),
                ),
    );
  }
}
