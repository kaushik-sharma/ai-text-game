import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/core.dart';
import '../../../../injection_container.dart' as di;
import '../../../../injection_container.dart';
import '../../../../routes/custom_navigator.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

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

    kSavedGame = await StorageHelpers.getSavedGame(sl<SharedPreferences>());

    if (!mounted) return;
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }
}
