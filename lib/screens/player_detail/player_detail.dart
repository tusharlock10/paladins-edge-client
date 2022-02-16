import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/player_detail/player_champions.dart';
import 'package:paladinsedge/screens/player_detail/player_detail_header.dart';
import 'package:paladinsedge/screens/player_detail/player_matches.dart';
import 'package:paladinsedge/widgets/index.dart' as widgets;

class PlayerDetail extends HookConsumerWidget {
  static const routeName = '/playerDetail';

  const PlayerDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final player = ref.watch(providers.players.select((_) => _.playerData));
    final playerId = ref.watch(providers.players.select((_) => _.playerId));
    final isLoadingPlayerData =
        ref.watch(providers.players.select((_) => _.isLoadingPlayerData));
    final playersProvider = ref.read(providers.players);
    final matchesProvider = ref.read(providers.matches);
    final championsProvider = ref.read(providers.champions);

    // Methods
    final onForceUpdate = useCallback(
      () => playersProvider.getPlayerData(forceUpdate: true),
      [playersProvider.playerData],
    );

    // Effects
    useEffect(
      () {
        // check if the playerId will should always be present in the provider
        // before this screen is accessed
        // if player is null, then call getplayerData

        if (playerId == null) return;
        if (player == null) {
          // fetch playerData from server
          playersProvider.getPlayerData(forceUpdate: false);
        }

        // get the playerMatches and plaerChampions from server
        matchesProvider.getPlayerMatches(playerId);
        championsProvider.getPlayerChampions(playerId);

        return;
      },
      [playerId],
    );

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Player Details'),
        ),
        body: player == null
            ? const Center(
                child: widgets.LoadingIndicator(
                  size: 36,
                ),
              )
            : Column(
                children: [
                  PlayerDetailHeader(
                    player: player,
                    onForceUpdate: onForceUpdate,
                    isLoading: isLoadingPlayerData,
                  ),
                  const TabBar(
                    tabs: [
                      Tab(text: "Matches"),
                      Tab(text: "Champions"),
                    ],
                  ),
                  const Expanded(
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        PlayerMatches(),
                        PlayerChampions(),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
