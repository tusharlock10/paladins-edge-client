import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
}
