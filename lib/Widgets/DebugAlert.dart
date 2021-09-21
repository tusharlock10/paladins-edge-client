import 'package:flutter/material.dart';

import '../Constants.dart' as Constants;

void showDebugAlert({message: String, context: BuildContext}) {
  // shows a alert with the message for easy debugging :)
  if (!Constants.IsDebug) return;
  showDialog(context: context, builder: (_) => _DebugAlert(message: message));
}

class _DebugAlert extends StatelessWidget {
  final String message;
  const _DebugAlert({required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(this.message),
      elevation: 10,
    );
  }
}
