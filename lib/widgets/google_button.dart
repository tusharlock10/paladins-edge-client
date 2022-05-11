import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paladinsedge/gen/assets.gen.dart';
import 'package:paladinsedge/theme/index.dart' as theme;
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class GoogleButton extends HookWidget {
  final bool isLoggingIn;
  final void Function() onGoogleSignIn;
  final void Function()? onGuestLogin;
  final double? width;

  const GoogleButton({
    required this.isLoggingIn,
    required this.onGoogleSignIn,
    this.onGuestLogin,
    this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final enableGuestLogin = utilities.RemoteConfig.enableGuestLogin;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 54,
          width: width,
          child: widgets.InteractiveCard(
            elevation: 5,
            hoverElevation: 10,
            borderRadius: 15,
            onTap: onGoogleSignIn,
            disableHover: true,
            padding: const EdgeInsets.symmetric(horizontal: 25),
            color: Colors.white,
            child: Row(
              mainAxisSize: width == null ? MainAxisSize.min : MainAxisSize.max,
              children: [
                isLoggingIn
                    ? const SizedBox(
                        width: 34,
                        height: 34,
                        child: widgets.LoadingIndicator(
                          lineWidth: 2,
                          size: 28,
                          color: theme.themeMaterialColor,
                        ),
                      )
                    : Assets.icons.googleColored.image(
                        width: 34,
                        height: 34,
                      ),
                const SizedBox(width: 20),
                Expanded(
                  flex: width == null ? 0 : 1,
                  child: Center(
                    child: Text(
                      'Continue with Google',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey.shade800,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
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
        const SizedBox(height: 12),
      ],
    );
  }
}
