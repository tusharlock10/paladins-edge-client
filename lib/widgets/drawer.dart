import 'package:flutter/material.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/widgets/index.dart' as widgets;
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  onLogout(BuildContext context) async {
    await Provider.of<providers.Auth>(context, listen: false).logout();
    Navigator.pushReplacementNamed(context, screens.Login.routeName);
  }

  onChangeTheme(BuildContext context) {
    final authProvider = Provider.of<providers.Auth>(context, listen: false);

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

  Widget buildPlayerProfile(BuildContext context) {
    final player = Provider.of<providers.Auth>(context).player;
    final textTheme = Theme.of(context).textTheme;

    if (player != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widgets.ElevatedAvatar(
            size: 20,
            borderRadius: 0,
            elevation: 5,
            imageUrl: player.avatarUrl!,
          ),
          const SizedBox(
            width: 5,
          ),
          Column(
            children: [
              Text(
                player.name,
                style: textTheme.headline1?.copyWith(fontSize: 18),
              ),
              player.title != null
                  ? Text(
                      player.title!,
                      style: textTheme.bodyText1?.copyWith(fontSize: 12),
                    )
                  : const SizedBox(),
            ],
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
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
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            buildPlayerProfile(context),
            buildDrawerButton(
              context,
              'Change Theme',
              () => onChangeTheme(context),
            ),
            buildDrawerButton(
              context,
              'Friends',
              () => onFriends(context),
            ),
            buildDrawerButton(
              context,
              'Logout',
              () => onLogout(context),
            ),
          ],
        ),
      ),
    );
  }
}
