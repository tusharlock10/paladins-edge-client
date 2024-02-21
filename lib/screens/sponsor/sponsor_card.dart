import "package:flutter/material.dart";
import "package:paladinsedge/screens/sponsor/sponsor_button.dart";

class SponsorCard extends StatelessWidget {
  final bool hasSponsors;

  const SponsorCard({
    required this.hasSponsors,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final textTheme = Theme.of(context).textTheme;
    final headingTheme = textTheme.displayLarge?.copyWith(
      fontSize: 22,
      fontWeight: FontWeight.normal,
    );
    final pointersTheme = textTheme.bodyLarge?.copyWith(
      fontSize: 16,
    );

    return Center(
      child: SizedBox(
        width: double.infinity,
        child: Card(
          elevation: 10,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ), // Set your desired radius here
          ),
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hasSponsors
                      ? "Become our first sponsor!"
                      : "Why sponsor Paladins Edge?",
                  style: headingTheme,
                ),
                const SizedBox(height: 20),
                FittedBox(
                  child: Text(
                    "1. App improvement and bug fixes",
                    style: pointersTheme,
                  ),
                ),
                FittedBox(
                  child: Text(
                    "2. Help fund new features coming in future",
                    style: pointersTheme,
                  ),
                ),
                FittedBox(
                  child: Text(
                    "3. Cover server costs for reliable operation",
                    style: pointersTheme,
                  ),
                ),
                const SizedBox(height: 30),
                const SponsorButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
