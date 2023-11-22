import 'package:flutter/material.dart';

import 'core/constants/app_metadata.dart';
import 'core/styles/app_themes.dart';
import 'routes/custom_navigator.dart';

class GameApp extends StatelessWidget {
  const GameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: kAppName,
      theme: AppThemes.dark,
      navigatorKey: kNavigatorKey,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: CustomNavigator.onGenerateRoute,
      scrollBehavior: ScrollConfiguration.of(context).copyWith(
        physics: const BouncingScrollPhysics(),
      ),
    );
  }
}
