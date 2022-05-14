import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:paladinsedge/screens/app_drawer/index.dart';
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/screens/main/main_bottom_tabs.dart';
import 'package:paladinsedge/screens/main/main_pages_stack.dart';
import 'package:paladinsedge/utilities/index.dart' as utilities;

class Main extends HookWidget {
  static const routeName = 'main';
  static const routePath = '/';
  final int startIndex;
  const Main({
    this.startIndex = 0,
    Key? key,
  }) : super(key: key);

  static GoRoute goRouteBuilder(List<GoRoute> routes) => GoRoute(
        name: routeName,
        path: routePath,
        builder: _routeBuilder,
        routes: routes,
        redirect: _routeRedirect,
      );

  @override
  Widget build(BuildContext context) {
    // State
    final selectedIndex = useState(startIndex);

    // Methods
    final onDrawerChanged = useCallback(
      (bool isOpened) {
        if (isOpened) utilities.unFocusKeyboard(context);
      },
      [],
    );

    final onItemSelected = useCallback(
      (int index) {
        selectedIndex.value = index;
      },
      [],
    );

    return Scaffold(
      drawer: const AppDrawer(),
      drawerEnableOpenDragGesture: false,
      onDrawerChanged: onDrawerChanged,
      body: MainPagesStack(selectedIndex: selectedIndex.value),
      bottomNavigationBar: MainBottomTabs(
        selectedIndex: selectedIndex.value,
        onItemSelected: onItemSelected,
      ),
    );
  }

  static Main _routeBuilder(_, __) => const Main(startIndex: 0);

  static String? _routeRedirect(GoRouterState _) {
    if (utilities.Global.isInitialRoute && !utilities.Global.isAuthenticated) {
      utilities.Global.isInitialRoute = false;

      return screens.Login.routePath;
    } else {
      utilities.Global.isInitialRoute = false;
    }

    return null;
  }
}
