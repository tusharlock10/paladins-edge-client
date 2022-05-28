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
  static final goRoute = GoRoute(
    name: routeName,
    path: routePath,
    builder: _routeBuilder,
  );
  static const userRouteName = "userFriends";
  static const userRoutePath = "userFriends";
  static final userGoRoute = GoRoute(
    name: userRouteName,
    path: userRoutePath,
    builder: _userRouteBuilder,
    redirect: utilities.Navigation.protectedRouteRedirect,
  );
  final String? otherPlayerId;

  const Friends({
    this.otherPlayerId,
    Key? key,
  }) : super(key: key);

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

  static Widget _routeBuilder(_, GoRouterState state) {
    final paramPlayerId = state.params["playerId"];
    if (paramPlayerId == null) {
      return const screens.NotFound();
    }

    if (int.tryParse(paramPlayerId) == null) return const screens.NotFound();
    final otherPlayerId = paramPlayerId;

    return Friends(
      otherPlayerId: otherPlayerId,
    );
  }

  static Friends _userRouteBuilder(_, __) => const Friends();
}
