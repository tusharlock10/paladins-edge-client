import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/screens/player_detail/player_detail_header.dart';
import 'package:paladinsedge/screens/player_detail/player_detail_matches.dart';
import 'package:paladinsedge/widgets/index.dart' as widgets;
import 'package:touchable_opacity/touchable_opacity.dart';

class PlayerDetail extends HookConsumerWidget {
  static const routeName = '/playerDetail';

  const PlayerDetail({Key? key}) : super(key: key);

  static BeamPage routeBuilder(BuildContext _, BeamState __, Object? ___) =>
      const BeamPage(
        key: ValueKey(routeName),
        title: 'Player • Paladins Edge',
        child: PlayerDetail(),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final player = ref.watch(providers.players.select((_) => _.playerData));
    final playerId = ref.watch(providers.players.select((_) => _.playerId));
    final playersProvider = ref.read(providers.players);
    final matchesProvider = ref.read(providers.matches);
    final championsProvider = ref.read(providers.champions);

    // Effects
    useEffect(
      () {
        // check if the playerId will should always be present in the provider
        // before this screen is accessed
        // if player is null, then call getPlayerData

        if (playerId == null) return;
        if (player == null) {
          // fetch playerData from server
          playersProvider.getPlayerData(forceUpdate: false);
          // fetch playerStatus from server
          playersProvider.getPlayerStatus(
            playerId: playerId,
            onlyStatus: true,
          );
        }

        return;
      },
      [playerId, player],
    );

    useEffect(
      () {
        if (playerId == null) return;
        if (player == null) return;

        // get the playerMatches and playerChampions from server
        // these apis require player to not be null
        matchesProvider.getPlayerMatches(playerId: playerId);
        championsProvider.getPlayerChampions(playerId);

        return;
      },
      [playerId, player],
    );

    // Methods
    final onTapChamps = useCallback(
      () {
        context.beamToNamed(screens.PlayerChampions.routeName);
      },
      [],
    );

    final onRefresh = useCallback(
      () async {
        if (playerId == null) return;

        final futures = [
          playersProvider.getPlayerStatus(
            playerId: playerId,
            forceUpdate: true,
            onlyStatus: true,
          ),
          matchesProvider.getPlayerMatches(
            playerId: playerId,
            forceUpdate: true,
          ),
        ];
        await Future.wait(futures);

        return;
      },
      [playerId],
    );

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: TouchableOpacity(
              onTap: onTapChamps,
              child: Center(
                child: Row(
                  children: const [
                    Text(
                      'Champs',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),
            ),
          ),
        ],
        title: player != null
            ? Column(
                children: [
                  Text(
                    player.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (player.title != null)
                    Text(
                      player.title!,
                      style: const TextStyle(fontSize: 12),
                    ),
                ],
              )
            : const Text('Loading'),
      ),
      body: player == null
          ? const widgets.LoadingIndicator(
              lineWidth: 2,
              size: 28,
              center: true,
              label: Text('Loading player'),
            )
          : widgets.Refresh(
              onRefresh: onRefresh,
              child: Stack(
                children: const [
                  PlayerDetailMatches(),
                  PlayerDetailHeader(),
                ],
              ),
            ),
    );
  }
}
