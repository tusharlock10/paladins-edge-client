import 'package:flutter/material.dart';

/// Callback that is called after Flutter is done painting a frame
/// eliminates the "markNeedsBuild" error
void postFrameCallback(void Function() callback) {
  WidgetsBinding.instance?.addPostFrameCallback((_) => callback());
}

/// Un-focuses the keyboard
/// Used when navigating to other page and keyboard should be hidden
unFocusKeyboard(BuildContext context) =>
    FocusScope.of(context).requestFocus(FocusNode());
