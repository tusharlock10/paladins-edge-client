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

    // State
    final isHover = useState(false);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MouseRegion(
          onEnter: (_) => isHover.value = true,
          onExit: (_) => isHover.value = false,
          child: widgets.Ripple(
            height: 54,
            width: width,
            decoration: isHover.value
                ? BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF202020).withOpacity(0.30),
                        blurRadius: 10,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  )
                : BoxDecoration(
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
            child: SizedBox(
              width: width,
              child: Row(
                mainAxisSize:
                    width == null ? MainAxisSize.min : MainAxisSize.max,
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
                        'SignIn with Google',
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
