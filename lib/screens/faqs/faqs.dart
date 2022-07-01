import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/constants.dart" as constants;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/faqs/faq_item.dart";
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

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

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            forceElevated: true,
            floating: true,
            snap: true,
            pinned: constants.isWeb,
            title: Text("FAQs"),
          ),
          faqs == null
              ? SliverList(
                  delegate: SliverChildListDelegate.fixed(
                    [
                      SizedBox(
                        height: utilities.getBodyHeight(context),
                        child: const Center(
                          child: widgets.LoadingIndicator(
                            lineWidth: 2,
                            size: 28,
                            label: Text("Getting FAQs"),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (_, index) => Padding(
                        padding: EdgeInsets.only(
                          top: index == 0 ? 7.5 : 0,
                          bottom: index == faqs.length - 1 ? 7.5 : 0,
                        ),
                        child: FaqItem(faq: faqs[index]),
                      ),
                      childCount: faqs.length,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  static Page _routeBuilder(_, __) => const CupertinoPage(child: Faqs());
}
