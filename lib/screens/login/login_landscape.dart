import "package:flutter/material.dart";
import "package:paladinsedge/screens/login/login_big_icon.dart";
import "package:paladinsedge/screens/login/login_tag_line.dart";
import "package:paladinsedge/widgets/index.dart" as widgets;

class LoginLandscape extends StatelessWidget {
  final bool isLoggingIn;
  final void Function() onGoogleSignIn;
  final void Function() onGuestLogin;
  final void Function() onFAQ;

  const LoginLandscape({
    required this.isLoggingIn,
    required this.onGoogleSignIn,
    required this.onGuestLogin,
    required this.onFAQ,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Flexible(
          flex: 1,
          child: LoginBigIcon(),
        ),
        Flexible(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const LoginTagLine(),
              widgets.GoogleButton(
                isLoggingIn: isLoggingIn,
                onGoogleSignIn: onGoogleSignIn,
                onGuestLogin: onGuestLogin,
                onFAQ: onFAQ,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
