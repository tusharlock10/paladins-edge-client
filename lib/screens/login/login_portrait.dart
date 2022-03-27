import 'package:flutter/material.dart';
import 'package:paladinsedge/screens/login/big_icon.dart';
import 'package:paladinsedge/screens/login/tag_line.dart';
import 'package:paladinsedge/widgets/index.dart' as widgets;

class LoginPortrait extends StatelessWidget {
  final bool isLoggingIn;
  final void Function() onGoogleSignIn;
  final void Function() onGuestLogin;

  const LoginPortrait({
    required this.isLoggingIn,
    required this.onGoogleSignIn,
    required this.onGuestLogin,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const BigIcon(),
        const TagLine(),
        widgets.GoogleButton(
          isLoggingIn: isLoggingIn,
          onGoogleSignIn: onGoogleSignIn,
          onGuestLogin: onGuestLogin,
        ),
      ],
    );
  }
}
