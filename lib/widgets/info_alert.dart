import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/widgets/loading_indicator.dart';

class InfoAlert extends StatefulWidget {
  const InfoAlert({Key? key}) : super(key: key);

  @override
  _InfoAlertState createState() => _InfoAlertState();
}

class _InfoAlertState extends State<InfoAlert> {
  PackageInfo? packageInfo;

  @override
  void initState() {
    PackageInfo.fromPlatform()
        .then((value) => setState(() => packageInfo = value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Dialog(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 350),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: packageInfo == null
              ? const Center(
                  child: LoadingIndicator(
                    size: 36,
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Here is some info for ya',
                      style: textTheme.headline1?.copyWith(fontSize: 24),
                    ),
                    const SizedBox(height: 20),
                    Text('App Name : ${packageInfo!.appName}'),
                    const Text('App Type : ${constants.appType}'),
                    Text('Package Name : ${packageInfo!.packageName}'),
                    Text('Version: ${packageInfo!.version}'),
                    const Text('API Url : ${constants.baseUrl}'),
                  ],
                ),
        ),
      ),
    );
  }
}
