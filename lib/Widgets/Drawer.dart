import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Center(
        child: TextButton(
          onPressed: () {},
          child: Text('Logout'),
        ),
      ),
    );
  }
}
