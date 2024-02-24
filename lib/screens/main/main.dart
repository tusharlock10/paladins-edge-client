import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/app_drawer/index.dart";
import "package:paladinsedge/screens/main/main_bottom_tabs.dart";
import "package:paladinsedge/screens/main/main_pages.dart";
import "package:paladinsedge/screens/main/main_pages_stack.dart";
import "package:paladinsedge/utilities/index.dart" as utilities;

class Main extends HookConsumerWidget {
  static const routeName = "main";
  static const routePath = "/";

  const Main({Key? key}) : super(key: key);

  static GoRoute goRouteBuilder(List<GoRoute> routes) => GoRoute(
        name: routeName,
        path: routePath,
        pageBuilder: _routeBuilder,
        routes: routes,
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final appStateProvider = ref.read(providers.appState);
    final bottomTabIndex = ref.watch(
      providers.appState.select((_) => _.bottomTabIndex),
    );

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
        appStateProvider.setBottomTabIndex(index);
      },
      [],
    );

    return Scaffold(
      drawer: const AppDrawer(),
      drawerEnableOpenDragGesture: constants.isMobile,
      drawerEdgeDragWidth: MediaQuery.of(context).size.width / 3,
      onDrawerChanged: onDrawerChanged,
      body: MainPagesStack(selectedIndex: bottomTabIndex),
      bottomNavigationBar: MainBottomTabs(
        selectedIndex: bottomTabIndex,
        onItemSelected: onItemSelected,
      ),
    );
  }

  static Page _routeBuilder(_, __) => const CupertinoPage(child: Main());
}
