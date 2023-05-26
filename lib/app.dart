import 'package:ai_text_game/features/game/presentation/pages/game_page.dart';
import 'package:flutter/material.dart';

import 'core/styles/themes.dart';

final GlobalKey<NavigatorState> kNavigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: Themes.dark,
      navigatorKey: kNavigatorKey,
      home: GamePage(),
    );
  }
}
