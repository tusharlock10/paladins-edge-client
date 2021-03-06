import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";

class AppDrawerGuestProfile extends StatelessWidget {
  const AppDrawerGuestProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          FeatherIcons.user,
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
