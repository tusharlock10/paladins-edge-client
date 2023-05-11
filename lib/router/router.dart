import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/router/routes.dart";
import "package:paladinsedge/screens/index.dart" as screens;
import "package:paladinsedge/utilities/index.dart" as utilities;

final _connectProfileExcludedRoutes = [
  screens.Feedback.routePath,
  screens.Faqs.routePath,
];

String? _routeRedirect(BuildContext _, GoRouterState state) {
  if (state.matchedLocation == screens.ConnectProfile.routePath) return null;
  if (utilities.Global.isAuthenticated && !utilities.Global.isPlayerConnected) {
    for (final excludedRoute in _connectProfileExcludedRoutes) {
      if (state.matchedLocation.contains(excludedRoute)) return null;
    }

    return screens.ConnectProfile.routePath;
  }

  return null;
}

final router = GoRouter(
  errorBuilder: screens.NotFound.routeBuilder,
  debugLogDiagnostics: constants.isDebug,
  initialLocation: screens.Main.routePath,
  redirect: _routeRedirect,
  routes: rootRoutes,
);
