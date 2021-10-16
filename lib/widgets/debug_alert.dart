import 'package:flutter/material.dart';
import 'package:paladinsedge/constants.dart' as constants;

void showDebugAlert(BuildContext context, String message) {
  // shows a alert with the message for easy debugging :)
  if (!constants.isDebug) return;
  showDialog(context: context, builder: (_) => _DebugAlert(message: message));
}

class _DebugAlert extends StatelessWidget {
  final String message;
  const _DebugAlert({required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(message),
      elevation: 10,
    );
  }
}
