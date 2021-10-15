import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/index.dart' as Models;
import '../Providers/index.dart' as Providers;
import '../Utilities/index.dart' as Utilities;
import '../Widgets/index.dart' as Widgets;

class Friends extends StatefulWidget {
  static const routeName = '/friends';

  @override
  _PlayerDetailState createState() => _PlayerDetailState();
}

class _PlayerDetailState extends State<Friends> {
  bool _init = true;
  bool _isLoading = true;
  final _friendsListKey = GlobalKey<AnimatedListState>();
  Models.Player? selectedFriend;

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
        playersProvider
            .getFriendsList(
          authProvider.player!.playerId,
          authProvider.user?.favouriteFriends,
        )
            .then((_) {
          this.setState(() => this._isLoading = false);
        });
      }
    }
    super.didChangeDependencies();
  }

  onSelectFriend(Models.Player selectedFriend) {
    if (this.selectedFriend?.playerId == selectedFriend.playerId) {
      return;
    }

    // get the playerStatus from the provider
    final playersProvider =
        Provider.of<Providers.Players>(context, listen: false);
    setState(() => this.selectedFriend = selectedFriend);
    playersProvider.getPlayerStatus(selectedFriend.playerId);
  }

  onFavouriteFriend() async {
    final authProvider = Provider.of<Providers.Auth>(context, listen: false);
    final playersProvider =
        Provider.of<Providers.Players>(context, listen: false);
    final newPlayedAdded =
        await authProvider.favouriteFriend(this.selectedFriend!.playerId);

    if (newPlayedAdded) {
      playersProvider.moveFriendToTop(this.selectedFriend!.playerId);
      this._friendsListKey.currentState?.insertItem(0);
    }
  }

  Widget buildLoading() {
    return Center(
      child: Widgets.LoadingIndicator(
        size: 36,
      ),
    );
  }

  Widget buildStatusIndicator(String status) {
    final theme = Theme.of(context);
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '$status',
            style: theme.textTheme.bodyText1,
          ),
          Container(
            height: 10,
            width: 10,
            margin: EdgeInsets.only(left: 7),
            decoration: BoxDecoration(
              color: status == "Offline" ? Colors.red : Colors.green,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPlayerMatchComponent(Models.ActiveMatch match, int team) {
    final teamInfo = match.playersInfo.where((player) => player.team == team);
    final textTheme = Theme.of(context).textTheme;
    final shouldReverse = team == 2;

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: teamInfo.map(
          (player) {
            return Row(
              mainAxisAlignment: !shouldReverse
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.end,
              children: Utilities.reverseWidgets(
                shouldReverse: shouldReverse,
                children: [
                  Widgets.ElevatedAvatar(
                    size: 20,
                    borderRadius: 20,
                    imageUrl: player.championImageUrl,
                  ),
                  Column(
                    crossAxisAlignment: !shouldReverse
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${player.player.playerId != "0" ? player.player.name : "Private Profile"}',
                        style: textTheme.bodyText1?.copyWith(fontSize: 12),
                      ),
                      Row(
                        children: Utilities.reverseWidgets(
                          shouldReverse: shouldReverse,
                          children: [
                            Widgets.FastImage(
                              imageUrl: player.player.rankIconUrl!,
                              height: 16,
                              width: 16,
                            ),
                            Text(
                              '${player.player.rankName}',
                              style:
                                  textTheme.bodyText1?.copyWith(fontSize: 10),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  Widget buildActiveMatchCard(Models.ActiveMatch? match) {
    if (match == null) {
      return SizedBox();
    }

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          this.buildPlayerMatchComponent(match, 1),
          this.buildPlayerMatchComponent(match, 2),
        ],
      ),
    );
  }

  Widget buildSelectedFriend() {
    final theme = Theme.of(context);
    final playerStatus = Provider.of<Providers.Players>(context).playerStatus;
    final favouriteFriends =
        Provider.of<Providers.Auth>(context).user?.favouriteFriends;
    final bool isFavourite =
        favouriteFriends?.contains(this.selectedFriend?.playerId) ?? false;

    return Column(
      children: [
        this.selectedFriend != null
            ? Card(
                elevation: 7,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${this.selectedFriend!.name}',
                                style: theme.textTheme.headline3,
                              ),
                              Text(
                                'Level ${this.selectedFriend!.level}',
                                style: theme.textTheme.bodyText2,
                              ),
                              Text(
                                '${this.selectedFriend!.platform}',
                                style: theme.textTheme.bodyText1,
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Widgets.Ripple(
                                  margin: EdgeInsets.only(bottom: 5),
                                  onTap: () => onFavouriteFriend(),
                                  child: Icon(
                                    isFavourite
                                        ? Icons.star
                                        : Icons.star_outline_outlined,
                                    size: 20,
                                    color: isFavourite
                                        ? Colors.yellow
                                        : theme.textTheme.bodyText1?.color,
                                  ),
                                ),
                                playerStatus != null
                                    ? this.buildStatusIndicator(
                                        playerStatus.status)
                                    : Widgets.LoadingIndicator(
                                        size: 16,
                                        lineWidth: 1.5,
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      this.buildActiveMatchCard(playerStatus?.match),
                    ],
                  ),
                ),
              )
            : Column(
                children: [
                  Text('* Select a friend to know his online status'),
                  Text('* Slide the friend card left to mark favourite')
                ],
              ),
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

  Widget buildFriend(Models.Player friend) {
    final theme = Theme.of(context);
    final favouriteFriends =
        Provider.of<Providers.Auth>(context).user?.favouriteFriends;
    final bool isFavourite =
        favouriteFriends?.contains(friend.playerId) ?? false;

    return Widgets.Ripple(
      onTap: () => this.onSelectFriend(friend),
      height: 80,
      child: Card(
        elevation: 7,
        child: Padding(
          padding: EdgeInsets.only(left: 15),
          child: Row(
            children: [
              friend.avatarUrl != null
                  ? Widgets.ElevatedAvatar(
                      size: 24,
                      borderRadius: 5,
                      imageUrl: friend.avatarUrl!,
                    )
                  : SizedBox(),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${friend.name}',
                      style: theme.textTheme.headline3?.copyWith(fontSize: 16),
                    ),
                    friend.title != null
                        ? Text(
                            '${friend.title}',
                            style: theme.textTheme.bodyText2
                                ?.copyWith(fontSize: 12),
                          )
                        : SizedBox(),
                    Text('${friend.platform}',
                        style:
                            theme.textTheme.bodyText1?.copyWith(fontSize: 10)),
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(),
              ),
              friend.ranked.rank != 0 && friend.ranked.rankIconUrl != null
                  ? Widgets.FastImage(
                      height: 36,
                      width: 36,
                      imageUrl: friend.ranked.rankIconUrl!,
                    )
                  : SizedBox(),
              Container(
                color: isFavourite ? Colors.yellow : Colors.transparent,
                height: 80,
                width: 3,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFriends() {
    final friendsList = Provider.of<Providers.Players>(context).friends;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        children: [
          Text("Total friends : ${friendsList.length}"),
          this.buildSelectedFriend(),
          Expanded(
            child: AnimatedList(
              key: this._friendsListKey,
              padding: EdgeInsets.only(top: 10),
              initialItemCount: friendsList.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index, animation) {
                final friend = friendsList[index];
                return SlideTransition(
                  position: animation.drive(
                    Tween<Offset>(
                      begin: const Offset(1, 0),
                      end: const Offset(0, 0),
                    ),
                  ),
                  child: this.buildFriend(friend),
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
