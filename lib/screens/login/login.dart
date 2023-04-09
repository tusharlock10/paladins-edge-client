import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/index.dart" as screens;
import "package:paladinsedge/screens/login/login_landscape.dart";
import "package:paladinsedge/screens/login/login_portrait.dart";
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

class Login extends HookConsumerWidget {
  static const routeName = "login";
  static const routePath = "/login";

  const Login({Key? key}) : super(key: key);

  static GoRoute goRouteBuilder(List<GoRoute> routes) => GoRoute(
        name: routeName,
        path: routePath,
        routes: routes,
        pageBuilder: _routeBuilder,
        redirect: _routeRedirect,
      );

  static Page _routeBuilder(_, __) => const CupertinoPage(child: Login());
  static String? _routeRedirect(GoRouterState _) {
    // check if user is authenticated
    // send him to main if authenticated
    if (utilities.Global.isAuthenticated) return screens.Main.routePath;

    return null;
  }

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
    final navigateToMain = useCallback(
      () {
        utilities.Navigation.navigate(
          context,
          screens.Main.routeName,
        );
      },
      [],
    );

    final onGoogleSignInFail = useCallback(
      (String error, int errorCode) {
        widgets.showToast(
          context: context,
          text: error,
          type: widgets.ToastType.error,
          errorCode: errorCode,
        );
      },
      [],
    );

    final onGoogleSignIn = useCallback(
      () async {
        if (isLoggingIn.value) {
          return;
        }

        isLoggingIn.value = true;

        final response = await authProvider.signInWithGoogle();
        if (response.result) {
          navigateToMain();
        } else {
          isLoggingIn.value = false;
          if (response.errorCode != null && response.errorMessage != null) {
            onGoogleSignInFail(response.errorMessage!, response.errorCode!);
          }
        }
      },
      [],
    );

    final onGuestLogin = useCallback(
      () {
        authProvider.loginAsGuest();
        utilities.Navigation.navigate(context, screens.Main.routeName);
      },
      [],
    );

    final onFAQ = useCallback(
      () {
        utilities.Navigation.navigate(context, screens.Faqs.loginRouteName);
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
                onFAQ: onFAQ,
              )
            : LoginLandscape(
                isLoggingIn: isLoggingIn.value,
                onGoogleSignIn: onGoogleSignIn,
                onGuestLogin: onGuestLogin,
                onFAQ: onFAQ,
              ),
      ),
    );
  }
}
