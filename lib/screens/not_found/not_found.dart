import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:paladinsedge/gen/assets.gen.dart';
import 'package:paladinsedge/screens/app_drawer/index.dart';
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class NotFound extends StatelessWidget {
  static const routeName = '/notFound';
  static const pageTitle = '404 • Paladins Edge';
  static const page = BeamPage(
    title: pageTitle,
    child: NotFound(),
  );

  const NotFound({Key? key}) : super(key: key);

  static BeamPage routeBuilder(BuildContext _, BeamState __, Object? ___) =>
      page;

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
        title: const Text('404'),
      ),
      drawer: const AppDrawer(),
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
              'Hehe, did I trick you?',
              style: textTheme.headline1?.copyWith(fontSize: 28),
            ),
            const SizedBox(height: 5),
            widgets.Button(
              label: 'Back to Home',
              onPressed: () => context.beamToNamed(
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
}
