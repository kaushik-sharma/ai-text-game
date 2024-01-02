import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/core.dart';
import 'routes/router_config.dart';

final GlobalKey<ScaffoldMessengerState> kScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

void main() {
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      builder: (context, child) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: kAppName,
        theme: AppThemes.dark,
        scaffoldMessengerKey: kScaffoldMessengerKey,
        scrollBehavior: const CustomScrollBehavior(),
        // home: const SplashPage(),
        // onGenerateRoute: CustomNavigator.onGenerateRoute,
        routerConfig: router,
      ),
    );
  }
}
