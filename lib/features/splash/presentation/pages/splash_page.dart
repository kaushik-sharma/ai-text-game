import 'package:flutter/material.dart';

import '../../../../core/constants/app_data.dart';
import '../../../../core/helpers/storage_helpers.dart';
import '../../../../core/managers/app_manager.dart';
import '../../../../injection_container.dart';
import '../../../../injection_container.dart' as di;
import '../../../../routes/custom_navigator.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }

  Future<void> _init() async {
    await di.init();
    await AppManager.init();

    kSavedGame = await StorageHelpers.getSavedGame(sl());

    if (!mounted) {
      return;
    }
    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }
}
