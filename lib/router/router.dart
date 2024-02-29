import "package:go_router/go_router.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/router/routes.dart";
import "package:paladinsedge/screens/index.dart" as screens;

final router = GoRouter(
  errorBuilder: screens.NotFound.routeBuilder,
  debugLogDiagnostics: constants.isDebug,
  initialLocation: screens.Main.routePath,
  routes: rootRoutes,
);
