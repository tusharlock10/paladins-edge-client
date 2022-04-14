import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GuestProfile extends StatelessWidget {
  const GuestProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          FontAwesomeIcons.userAstronaut,
          size: 24,
          color: textTheme.bodyText1?.color,
        ),
        const SizedBox(width: 10),
        Text(
          "Guest Profile",
          style: textTheme.headline1?.copyWith(
            fontSize: 18,
            color: textTheme.bodyText1?.color,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
