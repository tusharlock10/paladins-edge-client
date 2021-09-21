import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/index.dart' as Providers;
import '../Widgets/index.dart' as Widgets;

class Friends extends StatefulWidget {
  static const routeName = '/friends';

  @override
  _PlayerDetailState createState() => _PlayerDetailState();
}

class _PlayerDetailState extends State<Friends> {
  bool _init = true;
  bool _isLoading = true;

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void didChangeDependencies() {
    if (this._init) {
      this._init = false;
      final authProvider = Provider.of<Providers.Auth>(context, listen: false);
      final playersProvider =
          Provider.of<Providers.Players>(context, listen: false);
      if (authProvider.player?.playerId != null) {
        playersProvider.getFriendsList(authProvider.player!.playerId).then((_) {
          this.setState(() => this._isLoading = false);
        });
      }
    }
    super.didChangeDependencies();
  }

  Widget buildLoading() {
    return Center(
      child: Widgets.LoadingIndicator(
        size: 36,
      ),
    );
  }

  Widget buildFriends() {
    final friendsList = Provider.of<Providers.Players>(context).friendsList;
    final theme = Theme.of(context);

    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      itemCount: friendsList.length + 1,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        if (index == 0) {
          return Text("Total friends : ${friendsList.length}");
        }
        final friend = friendsList[index - 1];
        return Card(
          elevation: 7,
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${friend.name}',
                  style: theme.textTheme.headline3,
                ),
                Text('${friend.portal}', style: theme.textTheme.bodyText1),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Friends'),
      ),
      body: this._isLoading ? this.buildLoading() : this.buildFriends(),
    );
  }
}
