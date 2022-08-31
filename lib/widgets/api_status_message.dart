import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/utilities/index.dart" as utilities;

class ApiStatusMessage extends HookConsumerWidget {
  final String paladinsApiUnavailableMessage;
  final String serverMaintenanceMessage;

  const ApiStatusMessage({
    required this.paladinsApiUnavailableMessage,
    required this.serverMaintenanceMessage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final apiAvailable = ref.watch(
      providers.auth.select((_) => _.apiAvailable),
    );

    // Variables
    final paladinsApiUnavailable =
        utilities.RemoteConfig.paladinsApiUnavailable;
    final serverMaintenance = utilities.RemoteConfig.serverMaintenance;

    // Hooks
    final apiStatus = useMemoized(
      () {
        if (apiAvailable == null || serverMaintenance) {
          return data_classes.ApiStatus.serverMaintenance;
        }
        if (!apiAvailable || paladinsApiUnavailable) {
          return data_classes.ApiStatus.paladinsApiUnavailable;
        }

        return data_classes.ApiStatus.available;
      },
      [
        apiAvailable,
        paladinsApiUnavailable,
        serverMaintenance,
      ],
    );

    if (apiStatus == data_classes.ApiStatus.available) {
      return const SizedBox();
    }

    return Container(
      height: 64,
      width: double.infinity,
      color: apiStatus == data_classes.ApiStatus.serverMaintenance
          ? Colors.orangeAccent
          : Colors.red,
      padding: const EdgeInsets.only(top: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            apiStatus == data_classes.ApiStatus.paladinsApiUnavailable
                ? "It looks like Paladins API is unavailable right now"
                : "Paladins Edge servers are under maintenance",
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
              apiStatus == data_classes.ApiStatus.paladinsApiUnavailable
                  ? paladinsApiUnavailableMessage
                  : serverMaintenanceMessage,
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
