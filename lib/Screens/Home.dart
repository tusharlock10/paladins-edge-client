import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      AppBar(
        title: Text('Home'),
      ),
      Center(
        child: Text('Home'),
      ),
    ]);
  }
}
