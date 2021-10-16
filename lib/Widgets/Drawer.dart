import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/index.dart' as Providers;
import '../Screens/index.dart' as Screens;

class AppDrawer extends StatelessWidget {
  onLogout(BuildContext context) async {
    await Provider.of<Providers.Auth>(context, listen: false).logout();
    Navigator.pushReplacementNamed(context, Screens.Login.routeName);
  }

  onFriends(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).pushNamed(Screens.Friends.routeName);
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
          this.buildDrawerButton(
            context,
            'Change Theme',
            Provider.of<Providers.Auth>(context, listen: false).toggleTheme,
          ),
          this.buildDrawerButton(
            context,
            'Friends',
            () => this.onFriends(context),
          ),
          this.buildDrawerButton(
            context,
            'Logout',
            () => this.onLogout(context),
          ),
        ],
      ),
    );
  }
}
