import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/providers/index.dart" as providers;

class SponsorList extends ConsumerWidget {
  const SponsorList({Key? key}) : super(key: key);

  static const itemHeight = 50.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final sponsors = ref.watch(providers.auth.select((_) => _.sponsors));

    // Variables
    final textTheme = Theme.of(context).textTheme;

    return sponsors == null
        ? const SizedBox()
        : SizedBox(
            height: itemHeight,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 35),
              itemCount: sponsors.length + 1,
              separatorBuilder: ((context, index) => index == 0
                  ? const SizedBox(width: 20)
                  : const SizedBox(width: 10)),
              itemBuilder: (_, index) {
                if (index == 0) {
                  return Center(
                    child: Text(
                      "Our Sponsors",
                      style: textTheme.bodyLarge?.copyWith(fontSize: 20),
                    ),
                  );
                }

                final sponsor = sponsors[index - 1];

                return Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      width: 2,
                      color: textTheme.displayLarge!.color!,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          sponsor.name,
                          style: textTheme.displayLarge?.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          sponsor.paladinsName,
                          style: textTheme.bodyLarge?.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }
}
