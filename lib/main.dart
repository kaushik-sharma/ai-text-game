import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/constants/app_metadata.dart';
import 'core/styles/app_themes.dart';
import 'core/widgets/custom_scroll_behavior.dart';
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
        initialRoute: AppRoutes.splash,
        onGenerateRoute: CustomNavigator.onGenerateRoute,
        scrollBehavior: const CustomScrollBehavior(),
      ),
    );
  }
}
