import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/index.dart' as Providers;
import '../Screens/index.dart' as Screens;

class AppDrawer extends StatelessWidget {
  onLogout(BuildContext context) async {
    await Provider.of<Providers.Auth>(context, listen: false).logout();
    Navigator.pushReplacementNamed(context, Screens.Login.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextButton(
          onPressed: () => this.onLogout(context),
          child: Text('Logout'),
        ),
        TextButton(
          onPressed:
              Provider.of<Providers.Auth>(context, listen: false).toggleTheme,
          child: Text('ChangeTheme'),
        ),
      ]),
    );
  }
}
