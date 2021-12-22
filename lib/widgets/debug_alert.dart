import 'package:flutter/material.dart';
import 'package:paladinsedge/constants.dart' as constants;

void showDebugAlert({
  required BuildContext context,
  required String message,
  bool isDismissable = true,
  bool forceShow = false,
}) {
  // shows a alert with the message for easy debugging :)
  if (!forceShow && !constants.isDebug) return;
  showDialog(
    barrierDismissible: isDismissable,
    context: context,
    builder: (_) => _DebugAlert(
      message: message,
      title: "Debug Alert",
    ),
  );
}

class _DebugAlert extends StatelessWidget {
  final String message;
  final String title;
  const _DebugAlert({required this.message, required this.title});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Text(message),
      elevation: 5,
    );
  }
}
