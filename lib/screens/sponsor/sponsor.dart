import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/sponsor/sponsor_card.dart";
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

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
    // Providers
    final authProvider = ref.read(providers.auth);
    final sponsors = ref.watch(providers.auth.select((_) => _.sponsors));

    // Effects
    useEffect(
      () {
        if (sponsors == null) authProvider.getSponsors();

        return null;
      },
      [sponsors],
    );

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: sponsors == null
                  ? const Center(
                      child: widgets.LoadingIndicator(
                        lineWidth: 2,
                        size: 28,
                        label: Text("Loading Sponsors"),
                      ),
                    )
                  : SponsorCard(
                      hasSponsors: sponsors.isNotEmpty,
                    ),
            ),
            if (utilities.Navigation.canPop(context))
              Padding(
                padding: const EdgeInsets.all(4),
                child: IconButton(
                  onPressed: () => utilities.Navigation.pop(context),
                  icon: const Icon(FeatherIcons.arrowLeft),
                ),
              ),
          ],
        ),
      ),
    );
  }

  static Page _routeBuilder(_, __) => const CupertinoPage(child: Sponsor());
}
