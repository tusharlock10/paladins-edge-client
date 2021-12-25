import 'package:flutter/material.dart';
import 'package:paladinsedge/screens/login/big_icon.dart';
import 'package:paladinsedge/screens/login/google_button.dart';
import 'package:paladinsedge/screens/login/tag_line.dart';

class LoginPortrait extends StatelessWidget {
  final bool isLoggingIn;
  final void Function() onGoogleSignIn;

  const LoginPortrait({
    required this.isLoggingIn,
    required this.onGoogleSignIn,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const BigIcon(),
        const TagLine(),
        GoogleButton(
          isLoggingIn: isLoggingIn,
          onGoogleSignIn: onGoogleSignIn,
        ),
      ],
    );
  }
}
