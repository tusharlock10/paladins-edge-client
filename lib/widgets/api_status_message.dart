import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:paladinsedge/providers/index.dart" as providers;

class ApiStatusMessage extends ConsumerWidget {
  final String message;
  const ApiStatusMessage({
    required this.message,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final apiAvailable = ref.watch(
      providers.auth.select((_) => _.apiAvailable),
    );

    if (apiAvailable == true) {
      return const SizedBox();
    }

    return Container(
      height: 64,
      width: double.infinity,
      color: apiAvailable == null ? Colors.orangeAccent : Colors.red,
      padding: const EdgeInsets.only(top: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            apiAvailable == null
                ? "Paladins Edge servers are under maintenance"
                : "It looks like Paladins API is unavailable right now",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
