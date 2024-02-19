import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

class Sponsor extends HookConsumerWidget {
  static const routeName = "sponsor";
  static const routePath = "sponsor";
  static final goRoute = GoRoute(
    name: routeName,
    path: routePath,
    pageBuilder: _routeBuilder,
  );

  const Sponsor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Our Supporters"),
      ),
      body: const Text(""),
    );
  }

  static Page _routeBuilder(_, __) => const CupertinoPage(child: Sponsor());
}
