import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../routes/custom_navigator.dart';
import '../constants/app_values.dart';

class UiHelpers {
  static void hideKeyboard() {
    kNavigatorKey.currentState?.focusNode.requestFocus(FocusNode());
  }

  static void showSnackBar(String message) {
    kScaffoldMessengerKey.currentState!.clearSnackBars();
    kScaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  static Future<bool?> showConfirmDialog({
    required String title,
    required String content,
  }) async {
    final TextStyle actionStyle = TextStyle(
      fontSize: 12.sp,
      color: Theme.of(kNavigatorKey.currentContext!).colorScheme.primary,
    );

    return await showDialog<bool>(
      context: kNavigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        insetPadding: EdgeInsets.all(kScaffoldPadding),
        contentPadding: EdgeInsets.all(kScaffoldPadding),
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop<bool>(
              kNavigatorKey.currentContext!,
              false,
            ),
            child: Text(
              'No',
              style: actionStyle,
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop<bool>(
              kNavigatorKey.currentContext!,
              true,
            ),
            child: Text(
              'Yes',
              style: actionStyle,
            ),
          ),
        ],
      ),
    );
  }
}
