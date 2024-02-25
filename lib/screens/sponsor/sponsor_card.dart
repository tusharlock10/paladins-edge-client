import "package:flutter/material.dart";
import "package:paladinsedge/screens/sponsor/sponsor_button.dart";
import "package:paladinsedge/screens/sponsor/sponsor_list.dart";

class SponsorCard extends StatelessWidget {
  final bool hasSponsors;

  const SponsorCard({
    required this.hasSponsors,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    double horizontalPadding;
    double width;
    final size = MediaQuery.of(context).size;
    if (size.height < size.width) {
      // for landscape mode
      width = size.width * 0.5;
      horizontalPadding = (size.width - width) / 2;
    } else {
      // for portrait mode
      width = size.width;
      horizontalPadding = 15;
    }
    final textTheme = Theme.of(context).textTheme;
    final headingTheme = textTheme.displayLarge?.copyWith(
      fontSize: 22,
      fontWeight: FontWeight.normal,
    );
    final pointersTheme = textTheme.bodyLarge?.copyWith(
      fontSize: 16,
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          elevation: 10,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ), // Set your desired radius here
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hasSponsors
                            ? "Why sponsor Paladins Edge?"
                            : "Become our first sponsor!",
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
                    ],
                  ),
                ),
                if (hasSponsors) const SizedBox(height: 20),
                if (hasSponsors) const SponsorList(),
                const SizedBox(height: 30),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SponsorButton(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
