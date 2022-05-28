import "package:flutter/material.dart";

class CreateLoadoutText extends StatelessWidget {
  const CreateLoadoutText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Text("""
* Select a card from the list and drag it in the loadout
* Tap the card in the loadout to change its points
* Rename the loadout to your liking and save
"""),
    );
  }
}
