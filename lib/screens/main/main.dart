import 'package:beamer/beamer.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:paladinsedge/screens/app_drawer/index.dart';
import 'package:paladinsedge/screens/main/main_bottom_tabs.dart';
import 'package:paladinsedge/screens/main/main_pages_stack.dart';
import 'package:paladinsedge/utilities/index.dart' as utilities;

class Main extends HookWidget {
  static const routeName = "/";
  static const routeSearchName = "search";
  static const routeChampionsName = "champions";
  final int startIndex;

  const Main({
    this.startIndex = 0,
    Key? key,
  }) : super(key: key);

  static BeamPage routeBuilder(BuildContext _, BeamState state, Object? ___) {
    final pathSegments = state.uri.pathSegments;
    String key = _getKeyFromRoute(pathSegments.firstOrNull);
    int startIndex = _getIndexFromRoute(pathSegments.firstOrNull);

    return BeamPage(
      key: ValueKey(key),
      child: Main(
        startIndex: startIndex,
      ),
      title: 'Paladins Edge',
    );
  }

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
        Beamer.of(context).updateRouteInformation(
          RouteInformation(
            location: _getRouteFromIndex(index),
          ),
        );
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

  static String _getRouteFromIndex(int index) {
    if (index == 1) return routeSearchName;
    if (index == 2) return routeChampionsName;

    return routeName;
  }

  static int _getIndexFromRoute(String? route) {
    if (route == routeSearchName) return 1;
    if (route == routeChampionsName) return 2;

    return 0;
  }

  static String _getKeyFromRoute(String? route) {
    if (route == routeSearchName) return routeSearchName;
    if (route == routeChampionsName) return routeChampionsName;

    return 'main';
  }
}
