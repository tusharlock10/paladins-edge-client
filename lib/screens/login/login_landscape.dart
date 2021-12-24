import 'package:flutter/material.dart';
import 'package:paladinsedge/screens/login/big_icon.dart';
import 'package:paladinsedge/screens/login/google_button.dart';
import 'package:paladinsedge/screens/login/tag_line.dart';

class LoginLandscape extends StatelessWidget {
  final bool isLoggingIn;
  final void Function() onGoogleSignIn;

  const LoginLandscape({
    required this.isLoggingIn,
    required this.onGoogleSignIn,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Flexible(
          flex: 1,
          child: BigIcon(),
        ),
        Flexible(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TagLine(),
              GoogleButton(
                isLoggingIn: isLoggingIn,
                onGoogleSignIn: onGoogleSignIn,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
