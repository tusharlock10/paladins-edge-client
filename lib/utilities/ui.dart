import 'package:flutter/material.dart';

/// Callback that is called after Flutter is done painting a frame
/// eliminates the "markNeedsBuild" error
void postFrameCallback(void Function() callback) {
  WidgetsBinding.instance?.addPostFrameCallback((_) => callback());
}

/// Un-focuses the keyboard
/// Used when navigating to other page and keyboard should be hidden
void unFocusKeyboard(BuildContext context) =>
    FocusScope.of(context).requestFocus(FocusNode());

/// Get the height of top padding and appBar combined
double getTopEdgeOffset(BuildContext context) =>
    MediaQuery.of(context).padding.top + kToolbarHeight;

/// Get the available body height
double getBodyHeight(BuildContext context) =>
    MediaQuery.of(context).size.height - getTopEdgeOffset(context);
