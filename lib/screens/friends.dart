import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class Friends extends ConsumerStatefulWidget {
  static const routeName = '/friends';
  const Friends({Key? key}) : super(key: key);

  @override
  _PlayerDetailState createState() => _PlayerDetailState();
}

class _PlayerDetailState extends ConsumerState<Friends> {
  bool _init = true;
  bool _isLoading = true;
  final _friendsListKey = GlobalKey<AnimatedListState>();
  models.Player? selectedFriend;

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void didChangeDependencies() {
    if (_init) {
      final authProvider = ref.read(providers.auth);
      final playersProvider = ref.read(providers.players);

      _init = false;

      if (authProvider.player?.playerId != null) {
        playersProvider
            .getFriendsList(
          authProvider.player!.playerId,
          authProvider.user?.favouriteFriends,
        )
            .then((_) {
          setState(() => _isLoading = false);
        });
      }
    }
    super.didChangeDependencies();
  }

  onSelectFriend(models.Player friend) {
    if (selectedFriend?.playerId == friend.playerId) {
      return;
    }

    // get the playerStatus from the provider
    final playersProvider = ref.read(providers.players);
    setState(() => selectedFriend = friend);
    playersProvider.getPlayerStatus(friend.playerId);
  }

  onFavouriteFriend() async {
    final authProvider = ref.read(providers.auth);
    final playersProvider = ref.read(providers.players);

    final result =
        await authProvider.markFavouriteFriend(selectedFriend!.playerId);

    if (result == 2) {
      // user already has max number of friends
      // show a toast displaying this info

      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          elevation: 10,
          content: Text(
            "You cannot have more than ${utilities.Global.essentials!.maxFavouriteFriends} favourite friends",
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (result == 1) {
      // player is added in list
      playersProvider.moveFriendToTop(selectedFriend!.playerId);
      _friendsListKey.currentState?.insertItem(0);
    }
  }

  Widget buildLoading() {
    return const Center(
      child: widgets.LoadingIndicator(
        size: 36,
      ),
    );
  }

  Widget buildStatusIndicator(String status) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          status,
          style: theme.textTheme.bodyText1,
        ),
        Container(
          height: 10,
          width: 10,
          margin: const EdgeInsets.only(left: 7),
          decoration: BoxDecoration(
            color: status == "Offline" ? Colors.red : Colors.green,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );
  }

  Widget buildPlayerMatchComponent(models.ActiveMatch match, int team) {
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
              children: utilities.reverseWidgets(
                shouldReverse: shouldReverse,
                children: [
                  widgets.ElevatedAvatar(
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
                        player.player.playerId != "0"
                            ? player.player.name
                            : "Private Profile",
                        style: textTheme.bodyText1?.copyWith(fontSize: 12),
                      ),
                      Row(
                        children: utilities.reverseWidgets(
                          shouldReverse: shouldReverse,
                          children: [
                            widgets.FastImage(
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

  Widget buildActiveMatchCard(models.ActiveMatch? match) {
    if (match == null) {
      return const SizedBox();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildPlayerMatchComponent(match, 1),
        buildPlayerMatchComponent(match, 2),
      ],
    );
  }

  Widget buildSelectedFriend() {
    final theme = Theme.of(context);
    final playerStatus =
        ref.watch(providers.players.select((_) => _.playerStatus));
    final favouriteFriends =
        ref.watch(providers.auth.select((_) => _.user?.favouriteFriends));

    final bool isFavourite =
        favouriteFriends?.contains(selectedFriend?.playerId) ?? false;

    return Column(
      children: [
        selectedFriend != null
            ? Card(
                elevation: 7,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                selectedFriend!.name,
                                style: theme.textTheme.headline3,
                              ),
                              Text(
                                'Level ${selectedFriend!.level}',
                                style: theme.textTheme.bodyText2,
                              ),
                              Text(
                                '${selectedFriend!.platform}',
                                style: theme.textTheme.bodyText1,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                widgets.Ripple(
                                  margin: const EdgeInsets.only(bottom: 5),
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
                                    ? buildStatusIndicator(playerStatus.status)
                                    : const widgets.LoadingIndicator(
                                        size: 16,
                                        lineWidth: 1.5,
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      buildActiveMatchCard(playerStatus?.match),
                    ],
                  ),
                ),
              )
            : Column(
                children: const [
                  Text('* Select a friend to know his online status'),
                  Text('* Slide the friend card left to mark favourite')
                ],
              ),
        const SizedBox(height: 10),
        const Divider(
          height: 1,
          thickness: 1,
        ),
      ],
    );
  }

  Widget buildFriend(models.Player friend) {
    final theme = Theme.of(context);
    final favouriteFriends =
        ref.watch(providers.auth.select((_) => _.user?.favouriteFriends));

    final bool isFavourite =
        favouriteFriends?.contains(friend.playerId) ?? false;

    return widgets.Ripple(
      onTap: () => onSelectFriend(friend),
      height: 80,
      child: Card(
        elevation: 7,
        child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Row(
            children: [
              friend.avatarUrl != null
                  ? widgets.ElevatedAvatar(
                      size: 24,
                      borderRadius: 5,
                      imageUrl: friend.avatarUrl!,
                    )
                  : const SizedBox(),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      friend.name,
                      style: theme.textTheme.headline3?.copyWith(fontSize: 16),
                    ),
                    friend.title != null
                        ? Text(
                            '${friend.title}',
                            style: theme.textTheme.bodyText2
                                ?.copyWith(fontSize: 12),
                          )
                        : const SizedBox(),
                    Text('${friend.platform}',
                        style:
                            theme.textTheme.bodyText1?.copyWith(fontSize: 10)),
                  ],
                ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              friend.ranked.rank != 0 && friend.ranked.rankIconUrl != null
                  ? widgets.FastImage(
                      height: 36,
                      width: 36,
                      imageUrl: friend.ranked.rankIconUrl!,
                    )
                  : const SizedBox(),
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
    final friendsList = ref.watch(providers.players.select((_) => _.friends));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        children: [
          Text("Total friends : ${friendsList.length}"),
          buildSelectedFriend(),
          Expanded(
            child: AnimatedList(
              key: _friendsListKey,
              padding: const EdgeInsets.only(top: 10),
              initialItemCount: friendsList.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index, animation) {
                final friend = friendsList[index];
                return SlideTransition(
                  position: animation.drive(
                    Tween<Offset>(
                      begin: const Offset(1, 0),
                      end: const Offset(0, 0),
                    ),
                  ),
                  child: buildFriend(friend),
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
        title: const Text('Your Friends'),
      ),
      body: _isLoading ? buildLoading() : buildFriends(),
    );
  }
}
