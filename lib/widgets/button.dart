import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String label;
  final void Function() onPressed;

  const Button({
    required this.label,
    required this.onPressed,
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
          elevation: 0,
          shape: const StadiumBorder(),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
