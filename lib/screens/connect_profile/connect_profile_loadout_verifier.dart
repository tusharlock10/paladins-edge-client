import "package:flutter/material.dart";
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/screens/connect_profile/connect_profile_verify_help.dart";
import "package:paladinsedge/widgets/index.dart" as widgets;

class CreateProfileLoadoutVerifier extends StatelessWidget {
  final bool isVerifying;
  final bool showVerifyHelp;
  final String otp;
  final data_classes.LowerSearch? selectedPlayer;
  final void Function() onVerify;
  final void Function() onChangeName;

  const CreateProfileLoadoutVerifier({
    required this.isVerifying,
    required this.otp,
    required this.selectedPlayer,
    required this.onVerify,
    required this.onChangeName,
    required this.showVerifyHelp,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final headline6 = theme.textTheme.headline6;
    final secondaryColor = theme.colorScheme.secondary;

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 15),
          RichText(
            text: TextSpan(
              text: "Verifying for ",
              style: TextStyle(
                color: headline6?.color,
                fontFamily: headline6?.fontFamily,
              ),
              children: [
                TextSpan(
                  text: "${selectedPlayer?.name}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: "Create a loadout with the name ",
              style: TextStyle(
                color: headline6?.color,
                fontFamily: headline6?.fontFamily,
              ),
              children: [
                TextSpan(
                  text: otp,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const Text(
            "Wait a few seconds after saving",
          ),
          const Text(
            "Click verify once done",
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: 150,
            child: TextButton(
              onPressed: isVerifying ? null : onVerify,
              style: TextButton.styleFrom(
                side: BorderSide(width: 1.5, color: secondaryColor),
                backgroundColor: theme.scaffoldBackgroundColor,
              ),
              child: isVerifying
                  ? widgets.LoadingIndicator(
                      size: 18,
                      lineWidth: 1.5,
                      color: secondaryColor,
                    )
                  : Text(
                      "Verify",
                      style: TextStyle(color: secondaryColor),
                    ),
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: 150,
            child: TextButton(
              onPressed: onChangeName,
              style: TextButton.styleFrom(
                side: BorderSide(width: 1.5, color: secondaryColor),
                backgroundColor: theme.scaffoldBackgroundColor,
              ),
              child: Text(
                "Change name",
                style: TextStyle(color: secondaryColor),
              ),
            ),
          ),
          const SizedBox(height: 5),
          if (showVerifyHelp) const ConnectProfileVerifyHelp(),
        ],
      ),
    );
  }
}
