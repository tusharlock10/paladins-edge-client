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

  onSelectFriend(Models.Friend selectedFriend) {
    setState(() {
      this.selectedFriend = selectedFriend;
    });
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

    return Column(
      children: [
        Container(
          width: double.infinity,
          child: this.selectedFriend != null
              ? Card(
                  elevation: 7,
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${this.selectedFriend!.name}',
                          style: theme.textTheme.headline3,
                        ),
                        Text('${this.selectedFriend!.portal}',
                            style: theme.textTheme.bodyText1),
                      ],
                    ),
                  ),
                )
              : Text('*Select a friend to know his online status'),
        ),
        Divider(),
      ],
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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Total friends : ${friendsList.length}"),
              this.buildSelectedFriend(),
            ],
          );
        }
        final friend = friendsList[index - 1];
        return Widgets.Ripple(
          onTap: () => this.onSelectFriend(friend),
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
                  Text('${friend.portal}', style: theme.textTheme.bodyText1),
                ],
              ),
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
