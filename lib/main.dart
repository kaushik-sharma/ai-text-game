import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/core.dart';
import 'routes/custom_navigator.dart';

void main() {
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: kAppName,
        theme: AppThemes.dark,
        navigatorKey: kNavigatorKey,
        initialRoute: AppRoute.splash.name,
        onGenerateRoute: CustomNavigator.onGenerateRoute,
        scrollBehavior: const CustomScrollBehavior(),
      ),
    );
  }
}
