import 'package:flutter/material.dart';

class BigIcon extends StatelessWidget {
  const BigIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      transform: Matrix4.translationValues(0, -50.0, 0.0),
      child: Image.asset(
        'assets/icons/icon.png',
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
