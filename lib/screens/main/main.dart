import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:go_router/go_router.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/screens/app_drawer/index.dart";
import "package:paladinsedge/screens/main/main_bottom_tabs.dart";
import "package:paladinsedge/screens/main/main_pages.dart";
import "package:paladinsedge/screens/main/main_pages_stack.dart";
import "package:paladinsedge/utilities/index.dart" as utilities;

class Main extends HookWidget {
  static const routeName = "main";
  static const routePath = "/";
  final int startIndex;
  const Main({
    this.startIndex = 0,
    Key? key,
  }) : super(key: key);

  static GoRoute goRouteBuilder(List<GoRoute> routes) => GoRoute(
        name: routeName,
        path: routePath,
        pageBuilder: _routeBuilder,
        routes: routes,
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
        final tab = pages[index];
        utilities.Analytics.logEvent(
          constants.AnalyticsEvent.tabChange,
          {"tab": tab.title},
        );
        selectedIndex.value = index;
      },
      [],
    );

    return Scaffold(
      drawer: const AppDrawer(),
      drawerEnableOpenDragGesture: constants.isMobile,
      drawerEdgeDragWidth: MediaQuery.of(context).size.width / 3,
      onDrawerChanged: onDrawerChanged,
      body: MainPagesStack(selectedIndex: selectedIndex.value),
      bottomNavigationBar: MainBottomTabs(
        selectedIndex: selectedIndex.value,
        onItemSelected: onItemSelected,
      ),
    );
  }

  static Page _routeBuilder(_, __) =>
      const CupertinoPage(child: Main(startIndex: 0));
}
