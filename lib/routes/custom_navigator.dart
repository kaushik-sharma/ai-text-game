import 'package:flutter/material.dart';

import '../features/game/domain/entities/message_entity.dart';
import '../features/game/presentation/pages/game_page.dart';
import '../features/game/presentation/pages/game_theme_page.dart';
import '../features/home/presentation/pages/home_page.dart';
import '../features/splash/presentation/pages/splash_page.dart';

final GlobalKey<NavigatorState> kNavigatorKey = GlobalKey<NavigatorState>();

class AppRoutes {
  static const String splash = '/splash';
  static const String home = '/home';
  static const String gameTheme = '/game-theme';
  static const String game = '/game';
}

class CustomNavigator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => _mapNameToRoute(settings),
      settings: settings,
    );
  }

  static Widget _mapNameToRoute(RouteSettings settings) {
    final arguments = settings.arguments as Map<String, dynamic>?;

    switch (settings.name) {
      case AppRoutes.splash:
        return const SplashPage();
      case AppRoutes.home:
        return const HomePage();
      case AppRoutes.gameTheme:
        return const GameThemePage();
      case AppRoutes.game:
        return GamePage(
          theme: arguments!['theme'] as String,
          messages: arguments['messages'] as List<MessageEntity>?,
        );
      default:
        return const Scaffold();
    }
  }
}
