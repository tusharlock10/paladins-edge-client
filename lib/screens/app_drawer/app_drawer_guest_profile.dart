import "package:flutter/material.dart";

class AppDrawerGuestProfile extends StatelessWidget {
  const AppDrawerGuestProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Guest Profile",
          style: textTheme.bodyLarge?.copyWith(fontSize: 18),
        ),
        const SizedBox(width: 10),
        Text(
          "Login to use all features",
          style: textTheme.bodyLarge
              ?.copyWith(fontSize: 14, fontStyle: FontStyle.italic),
        ),
      ],
    );
  }
}
