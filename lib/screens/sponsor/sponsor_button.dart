import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:url_launcher/url_launcher_string.dart";

class SponsorButton extends StatelessWidget {
  const SponsorButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => launchUrlString(constants.sponsorLink),
            icon: const Icon(
              FeatherIcons.heart,
              color: Colors.white,
            ),
            label: const Text(
              "Support Us",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent.shade200,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(18.0)),
              ),
              elevation: 5,
              padding: const EdgeInsets.all(20),
            ),
          ),
        ),
      ],
    );
  }
}
