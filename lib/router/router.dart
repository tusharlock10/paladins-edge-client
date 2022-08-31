import "package:go_router/go_router.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/router/routes.dart";
import "package:paladinsedge/screens/index.dart" as screens;
import "package:paladinsedge/utilities/index.dart" as utilities;

final _connectProfileExcludedRoutes = [
  screens.Feedback.routePath,
  screens.Faqs.routePath,
];

String? _routeRedirect(GoRouterState state) {
  if (state.subloc == screens.ConnectProfile.routePath) return null;
  if (utilities.Global.isAuthenticated && !utilities.Global.isPlayerConnected) {
    for (final excludedRoute in _connectProfileExcludedRoutes) {
      if (state.subloc.contains(excludedRoute)) return null;
    }

    return screens.ConnectProfile.routePath;
  }

  return null;
}

final router = GoRouter(
  errorBuilder: screens.NotFound.routeBuilder,
  debugLogDiagnostics: constants.isDebug,
  initialLocation: screens.Main.routePath,
  urlPathStrategy: UrlPathStrategy.path,
  redirect: _routeRedirect,
  routes: rootRoutes,
);
