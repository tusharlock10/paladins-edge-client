import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/screens/login/login_landscape.dart';
import 'package:paladinsedge/screens/login/login_portrait.dart';
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class Login extends HookConsumerWidget {
  static const routeName = '/login';
  static const page = BeamPage(
    key: ValueKey(routeName),
    child: Login(),
    title: 'Login • Paladins Edge',
  );

  const Login({Key? key}) : super(key: key);

  static BeamPage routeBuilder(BuildContext _, BeamState __, Object? ___) =>
      page;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final authProvider = ref.read(providers.auth);

    // Variables
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    // State
    final isLoggingIn = useState(false);

    // Methods
    final onGoogleSignIn = useCallback(
      () async {
        if (isLoggingIn.value) {
          return;
        }

        isLoggingIn.value = true;

        final response = await authProvider.signInWithGoogle();
        if (response.result) {
          // after the user is logged in, send the device fcm token to the server
          final fcmToken = await utilities.Messaging.initMessaging();
          if (fcmToken != null) authProvider.sendFcmToken(fcmToken);

          context.beamToReplacementNamed(
            authProvider.user?.playerId == null
                ? screens.ConnectProfile.routeName
                : screens.Main.routeName,
          );
        } else {
          isLoggingIn.value = false;
          if (response.errorCode != null && response.errorMessage != null) {
            widgets.showToast(
              context: context,
              text: response.errorMessage!,
              type: widgets.ToastType.error,
              errorCode: response.errorCode,
            );
          }
        }
      },
      [],
    );

    final onGuestLogin = useCallback(
      () {
        authProvider.loginAsGuest();
        context.beamToReplacementNamed(screens.Main.routeName);
      },
      [],
    );

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF6DD5ED),
              Color(0xFF2193B0),
            ],
          ),
        ),
        child: height > width
            ? LoginPortrait(
                isLoggingIn: isLoggingIn.value,
                onGoogleSignIn: onGoogleSignIn,
                onGuestLogin: onGuestLogin,
              )
            : LoginLandscape(
                isLoggingIn: isLoggingIn.value,
                onGoogleSignIn: onGoogleSignIn,
                onGuestLogin: onGuestLogin,
              ),
      ),
    );
  }
}
