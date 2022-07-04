import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:package_info_plus/package_info_plus.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/widgets/loading_indicator.dart";

void showInfoAlert(BuildContext context) {
  showDialog(context: context, builder: (_) => const _InfoAlert());
}

class _InfoAlert extends HookWidget {
  const _InfoAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final textTheme = Theme.of(context).textTheme;

    // State
    final packageInfo = useState<PackageInfo?>(null);

    // Effects
    useEffect(
      () {
        PackageInfo.fromPlatform().then((temp) => packageInfo.value = temp);

        return null;
      },
      [],
    );

    return Dialog(
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 350),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: packageInfo.value == null
              ? const Center(
                  child: LoadingIndicator(
                    size: 36,
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Here is some info for ya",
                      style: textTheme.headline1?.copyWith(fontSize: 24),
                    ),
                    const SizedBox(height: 20),
                    Text("App Name : ${packageInfo.value!.appName}"),
                    Text("App Type : ${constants.Env.appType}"),
                    Text("Package Name : ${packageInfo.value!.packageName}"),
                    Text("Version: ${packageInfo.value!.version}"),
                    Text("API Url : ${constants.Env.baseUrl}"),
                  ],
                ),
        ),
      ),
    );
  }
}
