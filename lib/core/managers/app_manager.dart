import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../constants/app_metadata.dart';

class AppManager {
  static Future<void> init() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    kAppVersion = packageInfo.version;
  }
}
