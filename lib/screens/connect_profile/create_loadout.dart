import 'package:flutter/material.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class CreateLoadout extends StatelessWidget {
  final bool isVerifying;
  final String otp;
  final api.LowerSearch? selectedPlayer;
  final void Function() onVerify;
  final void Function() onChangeName;

  const CreateLoadout({
    required this.isVerifying,
    required this.otp,
    required this.selectedPlayer,
    required this.onVerify,
    required this.onChangeName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.headline6;
    return Column(
      children: [
        RichText(
          text: TextSpan(
            text: 'Verifying for ',
            style: TextStyle(
              color: textTheme?.color,
              fontFamily: textTheme?.fontFamily,
            ),
            children: [
              TextSpan(
                  text: '${selectedPlayer?.name}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            text: 'Create a loadout with the name ',
            style: TextStyle(
              color: textTheme?.color,
              fontFamily: textTheme?.fontFamily,
            ),
            children: [
              TextSpan(
                  text: otp,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        const Text('Click verify once you have created and saved your loadout'),
        TextButton(
          onPressed: onVerify,
          child: isVerifying
              ? const widgets.LoadingIndicator(
                  size: 18,
                  lineWidth: 2,
                )
              : const Text('Verify'),
        ),
        TextButton(
          onPressed: onChangeName,
          child: const Text('Change name'),
        )
      ],
    );
  }
}
