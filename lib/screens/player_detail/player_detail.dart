import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/player_detail/player_detail_component.dart';
import 'package:paladinsedge/screens/player_detail/player_matches.dart';
import 'package:paladinsedge/widgets/index.dart' as widgets;

class PlayerDetail extends ConsumerStatefulWidget {
  static const routeName = '/playerDetail';
  const PlayerDetail({Key? key}) : super(key: key);

  @override
  _PlayerDetailState createState() => _PlayerDetailState();
}

class _PlayerDetailState extends ConsumerState<PlayerDetail> {
  bool _init = true;

  @override
  void deactivate() {
    // remove the player data from provider when going back
    ref.read(providers.players).clearPlayerData();
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

      String? playerId = ModalRoute.of(context)?.settings.arguments as String?;
      if (playerId != null) {
        // fetch playerData from server
        ref.read(providers.players).getPlayerData(playerId);
      } else {
        // get the playerId from playerData
        playerId = ref.read(providers.players).playerData!.playerId;
      }

      // get the playerMatches from server
      ref.read(providers.matches).getPlayerMatches(playerId);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final player = ref.watch(providers.players.select((_) => _.playerData));

    return Scaffold(
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
                PlayerDetailComponent(player: player),
                const PlayerMatches(),
              ],
            ),
    );
  }
}
