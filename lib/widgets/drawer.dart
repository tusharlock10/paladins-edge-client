import 'package:flutter/material.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  onLogout(BuildContext context) async {
    await Provider.of<providers.Auth>(context, listen: false).logout();
    Navigator.pushReplacementNamed(context, screens.Login.routeName);
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
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildDrawerButton(
            context,
            'Change Theme',
            Provider.of<providers.Auth>(context, listen: false).toggleTheme,
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
    );
  }
}
