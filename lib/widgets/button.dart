import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String label;
  final void Function() onPressed;
  final bool disabled;

  const Button({
    required this.label,
    required this.onPressed,
    this.disabled = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final primaryColorLight = Theme.of(context).primaryColorLight;

    return SizedBox(
      height: 36,
      width: 128,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: primaryColorLight,
          shape: const StadiumBorder(),
        ),
        onPressed: disabled ? null : onPressed,
        child: Text(
          label,
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
