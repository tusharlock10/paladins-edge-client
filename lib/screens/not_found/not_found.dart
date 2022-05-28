import "package:flutter/material.dart";
import "package:paladinsedge/gen/assets.gen.dart";
import "package:paladinsedge/screens/index.dart" as screens;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

class NotFound extends StatelessWidget {
  const NotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final appBarHeight = MediaQuery.of(context).padding.top;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("404"),
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Assets.images.notFound.image(
                height: height / 2.5,
                width: width / 2.5,
              ),
            ),
            const SizedBox(height: 25),
            Text(
              "Hehe, did I trick you?",
              style: textTheme.headline1?.copyWith(fontSize: 28),
            ),
            const SizedBox(height: 5),
            widgets.Button(
              label: "Back to Home",
              onPressed: () => utilities.Navigation.navigate(
                context,
                screens.Main.routeName,
              ),
            ),
            SizedBox(
              height: appBarHeight,
            ),
          ],
        ),
      ),
    );
  }

  static NotFound routeBuilder(_, __) => const NotFound();
}
