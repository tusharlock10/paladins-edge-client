import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/widgets/drawer/player_profile.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({Key? key}) : super(key: key);

  onLogout(BuildContext context, WidgetRef ref) async {
    await ref.read(providers.auth).logout();
    Navigator.pushReplacementNamed(context, screens.Login.routeName);
  }

  onChangeTheme(BuildContext context, WidgetRef ref) {
    final authProvider = ref.read(providers.auth);

    if (authProvider.settings.themeMode == ThemeMode.dark) {
      authProvider.toggleTheme(ThemeMode.light);
    } else if (authProvider.settings.themeMode == ThemeMode.light) {
      authProvider.toggleTheme(ThemeMode.dark);
    } else {
      final brightness = Theme.of(context).brightness;
      authProvider.toggleTheme(
        brightness == Brightness.dark ? ThemeMode.light : ThemeMode.dark,
      );
    }
  }

  onFriends(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).pushNamed(screens.Friends.routeName);
  }

  Widget buildDrawerButton(
      BuildContext context, String label, void Function() onPressed) {
    final theme = Theme.of(context);
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: theme.textTheme.headline3
            ?.copyWith(color: theme.colorScheme.secondary),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const PlayerProfile(),
            buildDrawerButton(
              context,
              'Change Theme',
              () => onChangeTheme(context, ref),
            ),
            buildDrawerButton(
              context,
              'Friends',
              () => onFriends(context),
            ),
            buildDrawerButton(
              context,
              'Logout',
              () => onLogout(context, ref),
            ),
          ],
        ),
      ),
    );
  }
}
