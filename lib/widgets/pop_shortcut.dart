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
    // Hooks
    final focusNode = useFocusNode();

    // Methods
    final popChild = useCallback(
      () {
        utilities.Navigation.pop(context);
      },
      [focusNode],
    );

    final regainFocus = useCallback(
      (bool hasFocus) {
        if (!hasFocus) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (focusNode.canRequestFocus) {
              focusNode.requestFocus();
            }
          });
        }
      },
      [focusNode],
    );

    return CallbackShortcuts(
      bindings: {constants.ShortcutCombos.esc: popChild},
      child: Focus(
        autofocus: true,
        focusNode: focusNode,
        onFocusChange: regainFocus,
        child: child,
      ),
    );
  }
}
