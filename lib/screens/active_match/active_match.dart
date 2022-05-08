import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/data_classes/index.dart' as data_classes;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/active_match/active_match_list.dart';
import 'package:paladinsedge/screens/active_match/active_match_loading.dart';
import 'package:paladinsedge/screens/active_match/active_match_not_in_match.dart';
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class ActiveMatch extends HookConsumerWidget {
  static const routeName = 'activeMatch';
  static const routePath = 'activeMatch';
  static final goRoute = GoRoute(
    name: routeName,
    path: routePath,
    builder: _routeBuilder,
  );

  const ActiveMatch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final playersProvider = ref.read(providers.players);
    final championsProvider = ref.read(providers.champions);
    final authProvider = ref.read(providers.auth);
    final isLoadingPlayerStatus =
        ref.watch(providers.players.select((_) => _.isLoadingPlayerStatus));
    final playerStatus =
        ref.watch(providers.players.select((_) => _.playerStatus));
    final playerStatusPlayerId =
        ref.watch(providers.players.select((_) => _.playerStatusPlayerId));

    // Variables
    final isUserPlayer = authProvider.player?.playerId == playerStatusPlayerId;

    // Effects
    useEffect(
      () {
        if (playerStatusPlayerId != null) {
          playersProvider.getPlayerStatus(playerId: playerStatusPlayerId);
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
          return playersProvider.getPlayerStatus(
            playerId: playerStatusPlayerId,
            forceUpdate: true,
          );
        }
      },
      [],
    );

    return Scaffold(
      body: widgets.Refresh(
        edgeOffset: utilities.getTopEdgeOffset(context),
        onRefresh: onRefresh,
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              forceElevated: true,
              floating: true,
              snap: true,
              pinned: constants.isWeb,
              title: Text('Active Match'),
            ),
            playerStatus == null
                ? ActiveMatchLoading(
                    isLoadingPlayerStatus: isLoadingPlayerStatus,
                    isUserPlayer: isUserPlayer,
                  )
                : playerStatus.match == null
                    ? ActiveMatchNotInMatch(
                        status: playerStatus.status,
                        isUserPlayer: isUserPlayer,
                      )
                    : ActiveMatchList(playerStatus: playerStatus),
          ],
        ),
      ),
    );
  }

  static ActiveMatch _routeBuilder(_, __) => const ActiveMatch();
}
