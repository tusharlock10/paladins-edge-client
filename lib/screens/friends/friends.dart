import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/friends/friends_app_bar.dart";
import "package:paladinsedge/screens/friends/friends_list.dart";
import "package:paladinsedge/screens/index.dart" as screens;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

class Friends extends HookConsumerWidget {
  static const routeName = "friends";
  static const routePath = "friends";
  static const userRouteName = "user-friends";
  static const userRoutePath = "friends";

  const Friends({
    this.otherPlayerId,
    Key? key,
  }) : super(key: key);

  static Page _userRouteBuilder(_, __) => const CupertinoPage(child: Friends());
  static Page _routeBuilder(_, GoRouterState state) {
    final paramPlayerId = int.tryParse(state.params["playerId"] ?? "");
    if (paramPlayerId == null) {
      return const CupertinoPage(child: screens.NotFound());
    }

    return CupertinoPage(child: Friends(otherPlayerId: paramPlayerId));
  }

  final int? otherPlayerId;
  static final goRoute = GoRoute(
    name: routeName,
    path: routePath,
    pageBuilder: _routeBuilder,
  );
  static final userGoRoute = GoRoute(
    name: userRouteName,
    path: userRoutePath,
    pageBuilder: _userRouteBuilder,
    redirect: utilities.Navigation.protectedRouteRedirect,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final friendsProvider = ref.read(providers.friends);
    final userPlayerId =
        ref.watch(providers.auth.select((_) => _.player?.playerId));
    final isLoadingFriends =
        ref.watch(providers.friends.select((_) => _.isLoadingFriends));
    final fetchedAllFriends =
        ref.watch(providers.friends.select((_) => _.fetchedAllFriends));

    // Variables
    final isOtherPlayer =
        otherPlayerId != userPlayerId && otherPlayerId != null;
    final playerId = otherPlayerId ?? userPlayerId;

    // Effects
    useEffect(
      () {
        if (playerId != null && isOtherPlayer) {
          friendsProvider.getOtherFriends(playerId, false);
        } else if (playerId != null && !fetchedAllFriends) {
          friendsProvider.getUserFriends();
        }

        return;
      },
      [playerId, fetchedAllFriends, isOtherPlayer],
    );

    final onRefresh = useCallback(
      () {
        if (playerId != null && isOtherPlayer) {
          return friendsProvider.getOtherFriends(playerId, true);
        } else if (playerId != null) {
          return friendsProvider.getUserFriends(true);
        }

        return Future.value(null);
      },
      [],
    );

    return Scaffold(
      body: widgets.Refresh(
        onRefresh: onRefresh,
        edgeOffset: utilities.getTopEdgeOffset(context),
        child: CustomScrollView(
          slivers: [
            FriendsAppBar(
              isOtherPlayer: isOtherPlayer,
              onRefresh: onRefresh,
            ),
            isLoadingFriends
                ? SliverList(
                    delegate: SliverChildListDelegate.fixed(
                      [
                        SizedBox(
                          height: utilities.getBodyHeight(context),
                          child: const Center(
                            child: widgets.LoadingIndicator(
                              lineWidth: 2,
                              size: 28,
                              label: Text("Getting friends"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : FriendsList(
                    isOtherPlayer: isOtherPlayer,
                  ),
          ],
        ),
      ),
    );
  }
}
