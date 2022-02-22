import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/widgets/drawer/drawer_button.dart';
import 'package:paladinsedge/widgets/drawer/drawer_info.dart';
import 'package:paladinsedge/widgets/drawer/player_profile.dart';
import 'package:paladinsedge/widgets/index.dart' as widgets;

class AppDrawer extends HookConsumerWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final playersProvider = ref.read(providers.players);
    final player = ref.watch(providers.auth.select((_) => _.player));
    final authProvider = ref.read(providers.auth);
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

    final onFriends = useCallback(
      () {
        Navigator.of(context).popAndPushNamed(screens.Friends.routeName);
      },
      [],
    );

    final onActiveMatch = useCallback(
      () {
        if (player == null) return;

        playersProvider.setPlayerStatusPlayerId(player.playerId);
        Navigator.of(context).popAndPushNamed(screens.ActiveMatch.routeName);
      },
      [],
    );

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const PlayerProfile(),
            const SizedBox(height: 20),
            DrawerButton(
              context: context,
              label: 'Change Theme',
              subTitle: getThemeName(),
              onPressed: onChangeTheme,
            ),
            if (player != null)
              DrawerButton(
                context: context,
                label: 'Friends',
                onPressed: onFriends,
              ),
            if (player != null)
              DrawerButton(
                context: context,
                label: 'Active Match',
                onPressed: onActiveMatch,
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
                DrawerButton(
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
