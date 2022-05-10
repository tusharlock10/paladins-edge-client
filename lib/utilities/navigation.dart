import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/utilities/global.dart';

abstract class Navigation {
  /// Navigate to the screen with the name and params using go_router
  static void navigate(
    BuildContext context,
    String routeName, {
    Map<String, String>? params,
    Map<String, String>? queryParams,
  }) =>
      GoRouter.of(context).goNamed(
        routeName,
        params: params ?? const {},
        queryParams: queryParams ?? const {},
      );

  /// Pop using the Flutter navigator
  static void pop(BuildContext context) => Navigator.of(context).pop();

  /// Sanitized routePath by adding / in front
  /// eg. `connectProfile => /connectProfile`
  /// eg. `/ => /`
  /// eg. `/login => /login`
  static String sanitizeRoutePath(String routePath) =>
      routePath[0] == '/' ? routePath : '/$routePath';

  /// Redirects to login screen if an unauthenticated
  /// user lands on a protected route
  static String? protectedRouteRedirect(GoRouterState state) =>
      Global.isAuthenticated ? null : screens.Login.routePath;
}
