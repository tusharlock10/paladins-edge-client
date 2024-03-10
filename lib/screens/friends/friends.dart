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
  static final goRoute = GoRoute(
    name: routeName,
    path: routePath,
    pageBuilder: _routeBuilder,
  );
  static const userRouteName = "user-friends";
  static const userRoutePath = "friends";
  static final userGoRoute = GoRoute(
    name: userRouteName,
    path: userRoutePath,
    pageBuilder: _userRouteBuilder,
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
    final userPlayerId = ref.watch(
      providers.auth.select((_) => _.userPlayer?.playerId),
    );
    // Variables
    final isOtherPlayer =
        otherPlayerId != userPlayerId && otherPlayerId != null;
    final playerId = otherPlayerId ?? userPlayerId;
    final friendNotifier = providers.friends(playerId);
    final friendProvider = ref.read(friendNotifier);
    final isLoadingFriends = ref.watch(
      friendNotifier.select((_) => _.isLoadingFriends),
    );

    // State
    final isRefreshing = useState(false);

    // Effects
    useEffect(
      () {
        friendProvider.getFriends();

        return;
      },
      [friendProvider],
    );

    final onRefresh = useCallback(
      () async {
        isRefreshing.value = true;
        await friendProvider.getFriends(true);
        isRefreshing.value = false;
      },
      [],
    );

    return Scaffold(
      body: widgets.Refresh(
        onRefresh: onRefresh,
        edgeOffset: utilities.getTopEdgeOffset(context),
        child: CustomScrollView(
          slivers: [
            if (playerId != null)
              FriendsAppBar(
                isOtherPlayer: isOtherPlayer,
                onRefresh: onRefresh,
                isRefreshing: isRefreshing.value,
                playerId: playerId,
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
                    playerId: playerId,
                    isOtherPlayer: isOtherPlayer,
                  ),
          ],
        ),
      ),
    );
  }

  static Page _routeBuilder(_, GoRouterState state) {
    final paramPlayerId = state.pathParameters["playerId"];
    if (paramPlayerId == null) {
      return const CupertinoPage(child: screens.NotFound());
    }

    if (int.tryParse(paramPlayerId) == null) {
      return const CupertinoPage(child: screens.NotFound());
    }

    return CupertinoPage(
      child: widgets.PopShortcut(child: Friends(otherPlayerId: paramPlayerId)),
    );
  }

  static Page _userRouteBuilder(_, __) => const CupertinoPage(
        child: widgets.PopShortcut(child: Friends()),
      );
}
