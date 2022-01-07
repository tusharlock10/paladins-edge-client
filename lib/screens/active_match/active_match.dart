import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
    final playerStatus =
        ref.watch(providers.players.select((_) => _.playerStatus));
    final playerId = ref.read(providers.auth).player?.playerId;

    // Variables
    final width = MediaQuery.of(context).size.width;
    final playersInfoTeam1 =
        playerStatus?.match?.playersInfo.where((_) => _.team == 1);
    final playersInfoTeam2 =
        playerStatus?.match?.playersInfo.where((_) => _.team == 2);

    // State
    final isLoading = useState(true);

    // Effects
    useEffect(
      () {
        if (playerId != null) {
          playersProvider
              .getPlayerStatus(playerId)
              .then((_) => isLoading.value = false);
        }
      },
      [],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Match'),
      ),
      body: isLoading.value
          ? const widgets.LoadingIndicator(
              size: 28,
              label: Text('Loading Active Match'),
            )
          : SizedBox(
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    playerStatus!.status,
                    style: const TextStyle(fontSize: 18),
                  ),
                  playerStatus.match == null
                      ? const Text('You are not in a match')
                      : Text('${playerStatus.match?.map}'),
                  playersInfoTeam1 == null || playersInfoTeam2 == null
                      ? const SizedBox()
                      : Expanded(
                          child: ListView(
                            children: [
                              const Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    'Team 1',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                              ...playersInfoTeam1.map(
                                (_playerInfo) {
                                  return ActiveMatchPlayer(
                                    playerInfo: _playerInfo,
                                  );
                                },
                              ).toList(),
                              const Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    'Team 2',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                              ...playersInfoTeam2.map(
                                (_playerInfo) {
                                  return ActiveMatchPlayer(
                                    playerInfo: _playerInfo,
                                  );
                                },
                              ).toList(),
                            ],
                          ),
                        ),
                ],
              ),
            ),
    );
  }
}
