import 'package:flutter/material.dart';
import 'package:paladinsedge/screens/login/big_icon.dart';
import 'package:paladinsedge/screens/login/tag_line.dart';
import 'package:paladinsedge/widgets/index.dart' as widgets;

class LoginLandscape extends StatelessWidget {
  final bool isLoggingIn;
  final void Function() onGoogleSignIn;
  final void Function() onGuestLogin;

  const LoginLandscape({
    required this.isLoggingIn,
    required this.onGoogleSignIn,
    required this.onGuestLogin,
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
              widgets.GoogleButton(
                isLoggingIn: isLoggingIn,
                onGoogleSignIn: onGoogleSignIn,
                onGuestLogin: onGuestLogin,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
