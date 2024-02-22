import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/utilities/index.dart" as utilities;

class PopShortcut extends HookWidget {
  final Widget child;

  const PopShortcut({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Methods
    final popChild = useCallback(
      () {
        print("Popping child");
        if (utilities.Navigation.canPop(context)) {
          utilities.Navigation.pop(context);
        }
      },
      [],
    );

    return CallbackShortcuts(
      bindings: {constants.ShortcutCombos.esc: popChild},
      child: child,
    );
  }
}
