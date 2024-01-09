import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../features/game/data/models/message_model.dart';
import '../features/game/presentation/pages/game_page.dart';
import '../features/game/presentation/pages/game_theme_page.dart';
import '../features/home/presentation/pages/home_page.dart';
import '../features/splash/presentation/pages/splash_page.dart';

enum Routes {
  splash(name: 'splash'),
  home(name: 'home'),
  gameTheme(name: 'game-theme'),
  game(name: 'game');

  final String name;

  const Routes({required this.name});
}

final GoRouter router = GoRouter(
  navigatorKey: GlobalKey<NavigatorState>(),
  debugLogDiagnostics: true,
  routes: <GoRoute>[
    GoRoute(
      name: Routes.splash.name,
      path: '/',
      pageBuilder: (context, state) =>
          _buildPage(state.pageKey, const SplashPage()),
    ),
    GoRoute(
      name: Routes.home.name,
      path: '/${Routes.home.name}',
      pageBuilder: (context, state) =>
          _buildPage(state.pageKey, const HomePage()),
      routes: [
        GoRoute(
          name: Routes.gameTheme.name,
          path: Routes.gameTheme.name,
          pageBuilder: (context, state) =>
              _buildPage(state.pageKey, const GameThemePage()),
        ),
        GoRoute(
          name: Routes.game.name,
          path: '${Routes.game.name}/:theme',
          pageBuilder: (context, state) => _buildPage(
            state.pageKey,
            GamePage(
              theme: state.pathParameters['theme']!,
              messages: state.uri.queryParameters['messages'] == null
                  ? null
                  : MessageModel.fromJsonList(
                      state.uri.queryParameters['messages']!,
                    ),
            ),
          ),
        ),
      ],
    ),
  ],
);

Page _buildPage(LocalKey key, Widget child) => CupertinoPage(
      key: key,
      child: child,
    );
