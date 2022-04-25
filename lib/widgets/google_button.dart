import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paladinsedge/gen/assets.gen.dart';
import 'package:paladinsedge/theme/index.dart' as theme;
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class GoogleButton extends StatelessWidget {
  final bool isLoggingIn;
  final void Function() onGoogleSignIn;
  final void Function()? onGuestLogin;

  const GoogleButton({
    required this.isLoggingIn,
    required this.onGoogleSignIn,
    this.onGuestLogin,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final enableGuestLogin = utilities.RemoteConfig.enableGuestLogin;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        widgets.Ripple(
          margin: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
          width: width - 30,
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF202020).withOpacity(0.25),
                blurRadius: 5,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          onTap: onGoogleSignIn,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Row(
            children: [
              isLoggingIn
                  ? const SizedBox(
                      width: 36,
                      height: 36,
                      child: widgets.LoadingIndicator(
                        lineWidth: 2,
                        size: 28,
                        color: theme.themeMaterialColor,
                      ),
                    )
                  : Assets.icons.googleColored.image(
                      width: 36,
                      height: 36,
                    ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'SignIn with Google',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey.shade800,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if ((onGuestLogin != null) && enableGuestLogin)
          TextButton(
            onPressed: onGuestLogin,
            child: const Text(
              'Continue as guest',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        const SizedBox(height: 10),
      ],
    );
  }
}
