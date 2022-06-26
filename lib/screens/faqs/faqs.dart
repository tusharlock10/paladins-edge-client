import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

class Faqs extends HookConsumerWidget {
  static const routeName = "faqs";
  static const routePath = "faqs";
  static final goRoute = GoRoute(
    name: routeName,
    path: routePath,
    pageBuilder: _routeBuilder,
  );
  static const loginRouteName = "loginFaqs";
  static const loginRoutePath = "faqs";
  static final loginGoRoute = GoRoute(
    name: loginRouteName,
    path: loginRoutePath,
    pageBuilder: _routeBuilder,
  );

  const Faqs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FAQs"),
      ),
      body: const Text("FAQS"),
    );
  }

  static Page _routeBuilder(_, __) => const CupertinoPage(child: Faqs());
}
