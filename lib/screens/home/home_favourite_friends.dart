import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/home/home_favourite_friend_item.dart';
import 'package:paladinsedge/widgets/index.dart' as widgets;

class HomeFavouriteFriends extends HookConsumerWidget {
  const HomeFavouriteFriends({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final isLoadingFavouriteFriends =
        ref.watch(providers.friends.select((_) => _.isLoadingFavouriteFriends));
    final friends = ref.watch(providers.friends.select((_) => _.friends));
    final favouriteFriends =
        ref.watch(providers.auth.select((_) => _.user?.favouriteFriends));
    final friendsProvider = ref.read(providers.friends);

    // Variables
    final headingText =
        Theme.of(context).textTheme.headline1?.copyWith(fontSize: 16);
    final bodyText =
        Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 14);

    // Hooks
    final favouritePlayers = useMemoized(
      () {
        if (favouriteFriends != null && friends != null) {
          return friends
              .where((_) => favouriteFriends.contains(_.playerId))
              .toList();
        }
      },
      [friends, favouriteFriends],
    );

    // Effects
    useEffect(
      () {
        friendsProvider.getFavouriteFriends();

        return;
      },
      [],
    );

    return isLoadingFavouriteFriends
        ? const widgets.LoadingIndicator(
            lineWidth: 2,
            size: 28,
            label: Text('Loading friends'),
          )
        : favouritePlayers == null
            ? const Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      'Sorry we were unable to fetch your friends',
                    ),
                  ),
                ),
              )
            : favouritePlayers.isEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Card(
                      elevation: 7,
                      clipBehavior: Clip.antiAlias,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Column(
                          children: [
                            Text(
                              'Try adding some favourite friends',
                              style: headingText,
                            ),
                            const SizedBox(height: 5),
                            Text('*Visit the friends section', style: bodyText),
                            Text('*Select a friend', style: bodyText),
                            Text('*Mark him favourite', style: bodyText),
                            Text('*They will appear here', style: bodyText),
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    height: 90,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: favouritePlayers.length,
                      itemExtent: 300,
                      itemBuilder: (_, index) {
                        final friend = favouritePlayers[index];

                        return HomeFavouriteFriendItem(friend: friend);
                      },
                    ),
                  );
  }
}
