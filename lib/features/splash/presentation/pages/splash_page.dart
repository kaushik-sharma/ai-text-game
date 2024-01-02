import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/core.dart';
import '../../../../injection_container.dart' as di;
import '../../../../injection_container.dart';
import '../../../../routes/router_config.dart';
import '../../../game/presentation/blocs/game_bloc.dart';

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

    final gameData = await StorageHelpers.getSavedGame(sl<SharedPreferences>());
    sl<GameBloc>().add(GameEvent.saveGame(gameData));

    if (!mounted) return;
    // Navigator.pushReplacementNamed(context, AppRoute.home.name);
    context.goNamed(Routes.home.name);
  }
}
