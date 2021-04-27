import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/index.dart' as Models;
import '../Providers/index.dart' as Providers;
import '../Widgets/index.dart' as Widgets;

class PlayerDetail extends StatefulWidget {
  static const routeName = '/playerDetail';

  @override
  _PlayerDetailState createState() => _PlayerDetailState();
}

class _PlayerDetailState extends State<PlayerDetail> {
  bool _init = true;

  @override
  void deactivate() {
    Provider.of<Providers.Search>(context, listen: false).clearPlayerData();
    super.deactivate();
  }

  @override
  void didChangeDependencies() {
    if (this._init) {
      this._init = false;
      // check if the playerId is passed in arguments
      // if passed set loading to true and fetch the
      // data from server using playerId else show the player
      // from the playerData in provider

      final playerId = ModalRoute.of(context)?.settings.arguments as int?;
      if (playerId != null) {
        // fetch data from server
        Provider.of<Providers.Search>(context, listen: false)
            .getPlayerData(playerId);
      }
    }
    super.didChangeDependencies();
  }

  Widget buildLoading() {
    return Center(
        child: Widgets.LoadingIndicator(
      size: 36,
    ));
  }

  Widget buildPlayerDeatil(Models.Player player) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: [
          Row(
            children: [
              Widgets.ShadowAvatar(
                size: 36,
                imageUrl: player.avatarUrl!,
              ),
              Text('${player.name}')
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final player = Provider.of<Providers.Search>(context).playerData;

    return Scaffold(
      appBar: AppBar(
        title: Text('Player Details'),
      ),
      body:
          player == null ? this.buildLoading() : this.buildPlayerDeatil(player),
    );
  }
}
