import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/data_classes/index.dart' as data_classes;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/widgets/drawer/drawer_button.dart';
import 'package:paladinsedge/widgets/drawer/drawer_info.dart';
import 'package:paladinsedge/widgets/drawer/guest_profile.dart';
import 'package:paladinsedge/widgets/drawer/login_drawer_button.dart';
import 'package:paladinsedge/widgets/drawer/player_profile.dart';
import 'package:paladinsedge/widgets/index.dart' as widgets;
import 'package:paladinsedge/widgets/login_modal.dart';

class AppDrawer extends HookConsumerWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final playersProvider = ref.read(providers.players);
    final authProvider = ref.read(providers.auth);
    final player = ref.watch(providers.auth.select((_) => _.player));
    final isGuest = ref.watch(providers.auth.select((_) => _.isGuest));
    final themeMode =
        ref.watch(providers.auth.select((_) => _.settings.themeMode));

    // State
    final isLoggingOut = useState(false);

    // Methods
    final onLogout = useCallback(
      () async {
        isLoggingOut.value = true;
        final isLoggedOut = await ref.read(providers.auth).logout();

        if (isLoggedOut) {
          Navigator.pushReplacementNamed(context, screens.Login.routeName);
        } else {
          widgets.showToast(
            context: context,
            text: 'Unable to logout, try again later',
            type: widgets.ToastType.error,
          );
        }
        isLoggingOut.value = false;
      },
      [],
    );

    final onChangeTheme = useCallback(
      () {
        if (themeMode == ThemeMode.dark) {
          authProvider.toggleTheme(ThemeMode.light);
        } else if (themeMode == ThemeMode.light) {
          authProvider.toggleTheme(ThemeMode.system);
        } else {
          authProvider.toggleTheme(ThemeMode.dark);
        }
      },
      [themeMode],
    );

    final getThemeName = useCallback(
      () {
        if (themeMode == ThemeMode.dark) {
          return 'dark';
        } else if (themeMode == ThemeMode.light) {
          return 'light';
        } else if (themeMode == ThemeMode.system) {
          return 'system';
        } else {
          return null;
        }
      },
      [authProvider.settings.themeMode],
    );

    final _onFriends = useCallback(
      () {
        Navigator.of(context).popAndPushNamed(screens.Friends.routeName);
      },
      [],
    );

    final onFriends = useCallback(
      () {
        if (isGuest) {
          Navigator.of(context).pop();
          showLoginModal(
            data_classes.ShowLoginModalOptions(
              context: context,
              onSuccess: _onFriends,
              loginCta: constants.LoginCTA.friendsDrawer,
            ),
          );
        } else {
          _onFriends();
        }
      },
      [],
    );

    final _onActiveMatch = useCallback(
      () {
        if (player == null) return;

        playersProvider.setPlayerStatusPlayerId(player.playerId);
        Navigator.of(context).popAndPushNamed(screens.ActiveMatch.routeName);
      },
      [player],
    );

    final onActiveMatch = useCallback(
      () {
        if (isGuest) {
          Navigator.of(context).pop();
          showLoginModal(
            data_classes.ShowLoginModalOptions(
              context: context,
              onSuccess: _onActiveMatch,
              loginCta: constants.LoginCTA.activeMatchDrawer,
            ),
          );
        } else {
          _onActiveMatch();
        }
      },
      [],
    );

    final onFeedback = useCallback(
      () {
        Navigator.of(context).popAndPushNamed(screens.Feedback.routeName);
      },
      [player],
    );

    final showPlayerDependentButtons = useCallback(
      () {
        // to show or hide buttons dependant on player info
        // this scenario happens on connect profile screen
        // if user is a guest, then show the button but ask for
        // login on the specific screen
        return player != null || isGuest;
      },
      [],
    );

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            isGuest ? const GuestProfile() : const PlayerProfile(),
            const SizedBox(height: 20),
            DrawerButton(
              context: context,
              label: 'Change Theme',
              subTitle: getThemeName(),
              onPressed: onChangeTheme,
            ),
            if (showPlayerDependentButtons())
              DrawerButton(
                context: context,
                label: 'Friends',
                onPressed: onFriends,
              ),
            if (showPlayerDependentButtons())
              DrawerButton(
                context: context,
                label: 'Active Match',
                onPressed: onActiveMatch,
              ),
            DrawerButton(
              context: context,
              label: 'Feedback',
              onPressed: onFeedback,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isLoggingOut.value
                    ? const widgets.LoadingIndicator(
                        size: 16,
                        lineWidth: 2,
                      )
                    : const SizedBox(),
                isGuest
                    ? LoginDrawerButton(
                        context: context,
                        onPressed: onLogout,
                      )
                    : DrawerButton(
                        context: context,
                        label: 'Logout',
                        disabled: isLoggingOut.value,
                        onPressed: onLogout,
                      ),
              ],
            ),
            const DrawerInfo(),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
