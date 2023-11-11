import 'package:flutter/material.dart';

import '../../routes/custom_navigator.dart';
import '../constants/app_values.dart';

class UiHelpers {
  static void hideKeyboard() {
    kNavigatorKey.currentState?.focusNode.requestFocus(FocusNode());
  }

  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: kSnackBarDuration,
      ),
    );
  }

  static Future<bool?> showConfirmDialog({
    required String title,
    required String content,
  }) async {
    return await showDialog<bool>(
      context: kNavigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        insetPadding: const EdgeInsets.all(20),
        contentPadding: const EdgeInsets.all(20),
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
              style: _actionStyle,
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop<bool>(
              kNavigatorKey.currentContext!,
              true,
            ),
            child: Text(
              'Yes',
              style: _actionStyle,
            ),
          ),
        ],
      ),
    );
  }
}

final TextStyle _actionStyle = TextStyle(
  fontSize: 12,
  color: Theme.of(kNavigatorKey.currentContext!).colorScheme.primary,
);
