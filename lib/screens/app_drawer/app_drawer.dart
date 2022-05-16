import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/data_classes/index.dart' as data_classes;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/app_drawer/app_drawer_button.dart';
import 'package:paladinsedge/screens/app_drawer/app_drawer_guest_profile.dart';
import 'package:paladinsedge/screens/app_drawer/app_drawer_info.dart';
import 'package:paladinsedge/screens/app_drawer/app_drawer_login_button.dart';
import 'package:paladinsedge/screens/app_drawer/app_drawer_player_profile.dart';
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/utilities/index.dart' as utilities;
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
    final themeMode = ref.watch(
      providers.auth.select((_) => _.settings.themeMode),
    );

    // State
    final isLoggingOut = useState(false);

    // Methods
    final onLogout = useCallback(
      () async {
        isLoggingOut.value = true;
        final isLoggedOut = await ref.read(providers.auth).logout();

        if (isLoggedOut) {
          utilities.Navigation.pop(context);
          utilities.Navigation.navigate(context, screens.Login.routeName);
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
        utilities.Navigation.pop(context);
        utilities.Navigation.navigate(context, screens.Friends.userRouteName);
      },
      [],
    );

    final onFriends = useCallback(
      () {
        if (isGuest) {
          utilities.Navigation.pop(context);
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
        utilities.Navigation.pop(context);
        utilities.Navigation.navigate(
          context,
          screens.ActiveMatch.userRouteName,
        );
      },
      [player],
    );

    final onActiveMatch = useCallback(
      () {
        if (isGuest) {
          utilities.Navigation.pop(context);
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
        utilities.Navigation.pop(context);
        utilities.Navigation.navigate(context, screens.Feedback.routeName);
      },
      [player],
    );

    final onGlobalChat = useCallback(
      () {
        utilities.Navigation.pop(context);
        utilities.Navigation.navigate(context, screens.GlobalChat.routeName);
      },
      [],
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
            isGuest
                ? const AppDrawerGuestProfile()
                : const AppDrawerPlayerProfile(),
            const SizedBox(height: 20),
            AppDrawerButton(
              label: 'Change Theme',
              subTitle: getThemeName(),
              onPressed: onChangeTheme,
            ),
            if (showPlayerDependentButtons())
              AppDrawerButton(
                label: 'Friends',
                onPressed: onFriends,
              ),
            if (showPlayerDependentButtons())
              AppDrawerButton(
                label: 'Active Match',
                onPressed: onActiveMatch,
              ),
            AppDrawerButton(
              label: 'Feedback',
              onPressed: onFeedback,
            ),
            AppDrawerButton(
              label: 'Global Chat',
              onPressed: onGlobalChat,
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
                    ? AppDrawerLoginButton(
                        context: context,
                        onPressed: onLogout,
                      )
                    : AppDrawerButton(
                        label: 'Logout',
                        disabled: isLoggingOut.value,
                        onPressed: onLogout,
                      ),
              ],
            ),
            const AppDrawerInfo(),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
