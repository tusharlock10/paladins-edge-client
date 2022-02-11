import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/player_detail/player_champions.dart';
import 'package:paladinsedge/screens/player_detail/player_detail_component.dart';
import 'package:paladinsedge/screens/player_detail/player_matches.dart';
import 'package:paladinsedge/widgets/index.dart' as widgets;

class PlayerDetail extends HookConsumerWidget {
  static const routeName = '/playerDetail';

  const PlayerDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final player = ref.watch(providers.players.select((_) => _.playerData));
    final isLoadingPlayerData =
        ref.watch(providers.players.select((_) => _.isLoadingPlayerData));
    final playersProvider = ref.read(providers.players);
    final matchesProvider = ref.read(providers.matches);
    final championsProvider = ref.read(providers.champions);

    // Variables
    final routeArguments =
        ModalRoute.of(context)?.settings.arguments as String?;

    // Methods
    final onForceUpdate = useCallback(
      () {
        if (playersProvider.playerData?.playerId != null) {
          playersProvider.getPlayerData(
            playerId: playersProvider.playerData!.playerId,
            forceUpdate: true,
          );
        }
      },
      [playersProvider.playerData],
    );

    // Effects
    useEffect(
      () {
        // check if the playerId is passed in arguments
        // if passed set loading to true and fetch the
        // data from server using playerId else show the player
        // from the playerData in provider

        String? playerId = routeArguments;
        if (playerId != null) {
          // fetch playerData from server
          playersProvider.getPlayerData(playerId: playerId, forceUpdate: false);
        } else {
          // get the playerId from playerData
          playerId = playersProvider.playerData!.playerId;
        }

        // get the playerMatches and plaerChampions from server
        matchesProvider.getPlayerMatches(playerId);
        championsProvider.getPlayerChampions(playerId);

        // remove the player data from provider when going back
        return playersProvider.clearPlayerData;
      },
      [],
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
                  PlayerDetailComponent(
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
