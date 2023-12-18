import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../features/game/presentation/pages/game_page.dart';
import '../features/game/presentation/pages/game_theme_page.dart';
import '../features/home/presentation/pages/home_page.dart';
import '../features/splash/presentation/pages/splash_page.dart';

final GlobalKey<NavigatorState> kNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> kScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

enum AppRoute {
  splash(name: '/splash'),
  home(name: '/home'),
  gameTheme(name: '/game-theme'),
  game(name: '/game');

  final String name;

  const AppRoute({required this.name});

  static Widget mapNameToWidget(RouteSettings settings) {
    final arguments = settings.arguments as Map<String, dynamic>?;

    if (settings.name == AppRoute.splash.name) {
      return const SplashPage();
    } else if (settings.name == AppRoute.home.name) {
      return const HomePage();
    } else if (settings.name == AppRoute.gameTheme.name) {
      return const GameThemePage();
    } else if (settings.name == AppRoute.game.name) {
      return GamePage(
        theme: arguments?['theme'],
        messages: arguments?['messages'],
      );
    } else {
      return const Scaffold();
    }
  }
}

class CustomNavigator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return CupertinoPageRoute(
      builder: (context) => AppRoute.mapNameToWidget(settings),
      settings: settings,
    );
  }
}
