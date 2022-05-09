import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/screens/player_detail/player_detail_header.dart';
import 'package:paladinsedge/screens/player_detail/player_detail_matches.dart';
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/index.dart' as widgets;
import 'package:touchable_opacity/touchable_opacity.dart';

class PlayerDetail extends HookConsumerWidget {
  static const routeName = 'player';
  static const routePath = 'player/:playerId';
  final String playerId;

  const PlayerDetail({
    required this.playerId,
    Key? key,
  }) : super(key: key);

  static GoRoute goRouteBuilder(List<GoRoute> routes) => GoRoute(
        name: routeName,
        path: routePath,
        builder: _routeBuilder,
        routes: routes,
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final matchesProvider = ref.read(providers.matches);
    final playersProvider = ref.read(providers.players);
    final championsProvider = ref.read(providers.champions);
    final player = ref.watch(providers.players.select((_) => _.playerData));

    // Effects
    useEffect(
      () {
        // if player is null, then call getPlayerData

        if (player == null) {
          // fetch playerData from server
          playersProvider.getPlayerData(playerId: playerId, forceUpdate: false);
          // fetch playerStatus from server
          playersProvider.getPlayerStatus(
            playerId: playerId,
            onlyStatus: true,
          );
        }

        return;
      },
      [player],
    );

    useEffect(
      () {
        if (player == null) return;

        // get the playerMatches and playerChampions from server
        // these apis require player to not be null
        matchesProvider.getPlayerMatches(playerId: playerId);
        championsProvider.getPlayerChampions(playerId);

        return;
      },
      [player],
    );

    useEffect(
      () {
        // reset the player data in provider when unmounting
        return playersProvider.resetPlayerData;
      },
      [],
    );

    // Methods
    final onTapChamps = useCallback(
      () {
        utilities.Navigation.navigate(
          context,
          screens.PlayerChampions.routeName,
          params: {
            'playerId': playerId,
          },
        );
      },
      [],
    );

    final onRefresh = useCallback(
      () async {
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

  static Widget _routeBuilder(_, GoRouterState state) {
    final paramPlayerId = state.params['playerId'];
    if (paramPlayerId == null) {
      return const screens.NotFound();
    }

    if (int.tryParse(paramPlayerId) == null) return const screens.NotFound();
    final playerId = paramPlayerId;

    return PlayerDetail(playerId: playerId);
  }
}
