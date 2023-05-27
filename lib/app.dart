import 'package:ai_text_game/features/game/presentation/pages/game_page.dart';
import 'package:ai_text_game/routes/routes.dart';
import 'package:flutter/material.dart';

import 'core/styles/themes.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: Themes.dark,
      navigatorKey: kNavigatorKey,
      home: const GamePage(),
    );
  }
}
