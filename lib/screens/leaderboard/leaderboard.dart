import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/providers/index.dart" as providers;

class Leaderboard extends HookConsumerWidget {
  static const routeName = "leaderboard";
  static const routePath = "leaderboard";
  static final goRoute = GoRoute(
    name: routeName,
    path: routePath,
    pageBuilder: _routeBuilder,
  );

  const Leaderboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final authProvider = ref.read(providers.auth);
    final faqs = ref.watch(providers.auth.select((_) => _.faqs));

    // Variables
    double horizontalPadding = 0;
    double? width;
    final size = MediaQuery.of(context).size;
    if (size.height < size.width) {
      // for landscape mode
      width = size.width * 0.65;
      horizontalPadding = (size.width - width) / 2;
    }

    // Effects
    useEffect(
      () {
        if (faqs == null) authProvider.getFAQs();

        return;
      },
      [],
    );

    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            forceElevated: true,
            floating: true,
            snap: true,
            pinned: constants.isWeb,
            title: Text("Leaderboard"),
          ),
        ],
      ),
    );
  }

  static Page _routeBuilder(_, __) => const CupertinoPage(child: Leaderboard());
}
