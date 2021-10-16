import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import './LoadingIndicator.dart';
import '../Constants.dart' as Constants;

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
        .then((value) => this.setState(() => this.packageInfo = value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      child: Dialog(
        elevation: 5,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Container(
          constraints: BoxConstraints(maxHeight: 350),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: this.packageInfo == null
                ? Center(
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
                      SizedBox(height: 20),
                      Text('App Name : ${packageInfo!.appName}'),
                      Text('App Type : ${Constants.AppType}'),
                      Text('Package Name : ${packageInfo!.packageName}'),
                      Text('Version: ${packageInfo!.version}'),
                      Text('API Url : ${Constants.BaseUrl}'),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
