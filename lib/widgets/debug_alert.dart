import 'package:flutter/material.dart';
import 'package:paladinsedge/constants.dart' as constants;

void showDebugAlert({
  required BuildContext context,
  required String message,
  String? title,
  bool isDismissable = true,
}) {
  // shows a alert with the message for easy debugging :)
  if (!constants.isDebug) return;
  showDialog(
      barrierDismissible: isDismissable,
      context: context,
      builder: (_) => _DebugAlert(message: message));
}

class _DebugAlert extends StatelessWidget {
  final String message;
  final String? title;
  const _DebugAlert({required this.message, this.title = "Alert"});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title!),
      content: Text(message),
      elevation: 5,
    );
  }
}
