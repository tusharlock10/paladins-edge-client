import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:paladinsedge/screens/index.dart" as screens;
import "package:paladinsedge/utilities/analytics.dart";
import "package:paladinsedge/utilities/global.dart";

abstract class Navigation {
  /// Navigate to the screen with the name and params using go_router
  static void navigate(
    BuildContext context,
    String routeName, {
    Map<String, String>? params,
    Map<String, String>? queryParams,
  }) {
    Analytics.logScreenEntry(routeName);
    GoRouter.of(context).goNamed(
      routeName,
      pathParameters: params ?? const {},
      queryParameters: queryParams ?? const {},
    );
  }

  /// Navigate to the screen with the name and params using go_router,
  /// pushes the new screen on top of the old screen in teh router stack
  static void push(
    BuildContext context,
    String routeName, {
    Map<String, String>? params,
    Map<String, String>? queryParams,
  }) {
    Analytics.logScreenEntry(routeName);
    GoRouter.of(context).pushNamed(
      routeName,
      pathParameters: params ?? const {},
      queryParameters: queryParams ?? const {},
    );
  }

  /// Checks if can we pop
  static bool canPop(BuildContext context) => Navigator.of(context).canPop();

  /// Pop using the Flutter navigator, if canPop is true
  static void pop(BuildContext context, {bool forcePop = false}) {
    if (forcePop || Navigation.canPop(context)) {
      Navigator.of(context).pop();
    }
  }

  /// Sanitized routePath by adding / in front
  /// eg. `friends => /friends`
  /// eg. `/ => /`
  static String sanitizeRoutePath(String routePath) =>
      routePath[0] == "/" ? routePath : "/$routePath";

  /// Redirects to login screen if an unauthenticated
  /// user lands on a protected route
  static String? protectedRouteRedirect(BuildContext _, GoRouterState state) =>
      Global.isAuthenticated ? null : screens.Main.routePath;
}
