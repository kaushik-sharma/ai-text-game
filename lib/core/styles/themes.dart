import 'package:ai_text_game/core/styles/text_styles.dart';
import 'package:flutter/material.dart';

class Themes {
  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    fontFamily: kZenDots,
    scaffoldBackgroundColor: Colors.black,
    colorScheme: const ColorScheme.dark(
      primary: Colors.white,
    ),
  );
}
