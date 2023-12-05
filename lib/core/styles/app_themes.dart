import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../gen/fonts.gen.dart';

class AppThemes {
  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    fontFamily: FontFamily.zenDots,
    scaffoldBackgroundColor: _scaffoldBackgroundColor,
    colorScheme: const ColorScheme.dark(
      primary: _primaryColor,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: _scaffoldBackgroundColor,
      foregroundColor: _primaryColor,
    ),
    dialogTheme: DialogTheme(
      backgroundColor: _scaffoldBackgroundColor,
      surfaceTintColor: Colors.transparent,
      elevation: 8.r,
      shadowColor: _primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.r),
        side: const BorderSide(color: _primaryColor),
      ),
      titleTextStyle: TextStyle(
        fontSize: 18.sp,
        fontFamily: FontFamily.zenDots,
      ),
      contentTextStyle: TextStyle(
        fontSize: 14.sp,
        fontFamily: FontFamily.zenDots,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primaryColor,
        foregroundColor: Colors.black,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        alignment: Alignment.center,
        shape: const StadiumBorder(),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: _primaryColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        alignment: Alignment.center,
        shape: const StadiumBorder(),
      ),
    ),
  );
}

const Color _primaryColor = Colors.white;
const Color _scaffoldBackgroundColor = Colors.black;
