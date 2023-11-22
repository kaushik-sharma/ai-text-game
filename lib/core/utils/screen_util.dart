// import 'dart:math';
//
// import 'package:flutter/material.dart';
//
// class ScreenUtil {
//   static late final Size _designSize;
//
//   static void init({
//     required Size designSize,
//   }) {
//     _designSize = designSize;
//   }
//
//   /// Physical pixel size
//   // final FlutterView _flutterView = WidgetsBinding.instance.platformDispatcher.views.first;
//
//   static final MediaQueryData _mediaQueryData = MediaQueryData.fromView(
//       WidgetsBinding.instance.platformDispatcher.views.first);
//
//   static double get screenWidth => _mediaQueryData.size.width;
//
//   static double get screenHeight => _mediaQueryData.size.height;
//
//   static double get statusBarHeight => _mediaQueryData.viewPadding.top;
//
//   static double get keyboardHeight => _mediaQueryData.viewInsets.bottom;
//
//   static double get _scaleWidth => screenWidth / _designSize.width;
//
//   static double get _scaleHeight => screenHeight / _designSize.height;
//
//   static double get _scaleRadius => min(_scaleWidth, _scaleHeight);
//
//   static double getWidth(num width) => width * _scaleWidth;
//
//   static double getHeight(num height) => height * _scaleHeight;
//
//   static double getRadius(num radius) => radius * _scaleRadius;
//
//   static double getSp(num fontSize) => fontSize * _scaleRadius;
// }
//
// extension SizeExtension on num {
//   double get w => ScreenUtil.getWidth(this);
//
//   double get h => ScreenUtil.getHeight(this);
//
//   double get r => ScreenUtil.getRadius(this);
//
//   double get sp => ScreenUtil.getSp(this);
//
//   double get sw => ScreenUtil.screenWidth * this;
//
//   double get sh => ScreenUtil.screenHeight * this;
// }
