import "package:flutter/material.dart";
import "package:flutter/services.dart";

abstract class ShortcutCombos {
  static const ctrl1 = SingleActivator(
    LogicalKeyboardKey.digit1,
    control: true,
  );
  static const ctrl2 = SingleActivator(
    LogicalKeyboardKey.digit2,
    control: true,
  );
  static const ctrl3 = SingleActivator(
    LogicalKeyboardKey.digit3,
    control: true,
  );
  static const esc = SingleActivator(
    LogicalKeyboardKey.escape,
  );
  static const ctrlR = SingleActivator(
    LogicalKeyboardKey.keyR,
    control: true,
  );
}
