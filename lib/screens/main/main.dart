import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:paladinsedge/screens/app_drawer/index.dart';
import 'package:paladinsedge/screens/main/main_bottom_tabs.dart';
import 'package:paladinsedge/screens/main/main_pages_stack.dart';
import 'package:paladinsedge/utilities/index.dart' as utilities;

class Main extends HookWidget {
  static const routeName = "/main";
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // State
    final selectedIndex = useState(0);

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
}
