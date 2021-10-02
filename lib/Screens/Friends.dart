import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/index.dart' as Models;
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
  Models.Friend? selectedFriend;

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

  onSelectFriend(BuildContext context, Models.Friend selectedFriend) {
    // get the playerStatus from the provider

    final playersProvider =
        Provider.of<Providers.Players>(context, listen: false);
    setState(() => this.selectedFriend = selectedFriend);
    playersProvider.getPlayerStatus(selectedFriend.playerId);
  }

  Widget buildLoading() {
    return Center(
      child: Widgets.LoadingIndicator(
        size: 36,
      ),
    );
  }

  Widget buildSelectedFriend() {
    final theme = Theme.of(context);
    final playerStatus = Provider.of<Providers.Players>(context).playerStatus;

    return Column(
      children: [
        this.selectedFriend != null
            ? Card(
                elevation: 7,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${this.selectedFriend!.name}',
                            style: theme.textTheme.headline3,
                          ),
                          Text(
                            '${this.selectedFriend!.portal}',
                            style: theme.textTheme.bodyText1,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${playerStatus?.status}',
                            style: theme.textTheme.headline3,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : Text('*Select a friend to know his online status'),
        SizedBox(
          height: 10,
        ),
        Divider(
          height: 1,
          thickness: 1,
        ),
      ],
    );
  }

  Widget buildFriends() {
    final friendsList = Provider.of<Providers.Players>(context).friendsList;
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        children: [
          Text("Total friends : ${friendsList.length}"),
          this.buildSelectedFriend(),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 10),
              itemCount: friendsList.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final friend = friendsList[index];
                return Widgets.Ripple(
                  onTap: () => this.onSelectFriend(context, friend),
                  child: Card(
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
                          Text('${friend.portal}',
                              style: theme.textTheme.bodyText1),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
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
