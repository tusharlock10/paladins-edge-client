import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

class Shortcuts extends HookWidget {
  final Widget child;
  final Map<ShortcutActivator, VoidCallback> bindings;
  final bool shouldRequestFocus;
  final String? debugLabel;

  const Shortcuts({
    required this.child,
    required this.bindings,
    this.shouldRequestFocus = true,
    this.debugLabel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Hooks
    final focusNode = useFocusNode();

    // Effects
    useEffect(
      () {
        if (shouldRequestFocus) {
          print(
              "GETTING FOCUS : $debugLabel, shouldRequestFocus: $shouldRequestFocus");
          focusNode.requestFocus();
        } else {
          print(
              "UNFOCUSING : $debugLabel, shouldRequestFocus: $shouldRequestFocus");
          focusNode.unfocus();
        }

        return null;
      },
      [shouldRequestFocus],
    );

    // Methods
    final regainFocus = useCallback(
      (bool hasFocus) {
        if (shouldRequestFocus && !hasFocus) {
          print(
              "REGAINING FOCUS : $debugLabel, shouldRequestFocus: $shouldRequestFocus");
          focusNode.requestFocus();
        }
      },
      [focusNode, shouldRequestFocus],
    );

    return CallbackShortcuts(
      bindings: bindings,
      child: Focus(
        onFocusChange: regainFocus,
        child: child,
      ),
    );
  }
}
