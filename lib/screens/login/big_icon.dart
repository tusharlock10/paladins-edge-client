import 'package:flutter/material.dart';
import 'package:paladinsedge/gen/assets.gen.dart';

class BigIcon extends StatelessWidget {
  const BigIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      transform: Matrix4.translationValues(0, -50.0, 0.0),
      child: Assets.icons.icon.image(
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
