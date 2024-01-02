import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../main.dart';
import '../../routes/router_config.dart';
import '../core.dart';

class UiHelpers {
  static void hideKeyboard() {
    router.configuration.navigatorKey.currentState!.focusNode
        .requestFocus(FocusNode());
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
      color: Theme.of(router.configuration.navigatorKey.currentContext!)
          .colorScheme
          .primary,
    );

    return await showDialog<bool>(
      context: router.configuration.navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        insetPadding: EdgeInsets.all(kScaffoldPadding),
        contentPadding: EdgeInsets.all(kScaffoldPadding),
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => router.configuration.navigatorKey.currentContext!
                .pop<bool>(false),
            child: Text(
              'No',
              style: actionStyle,
            ),
          ),
          TextButton(
            onPressed: () => router.configuration.navigatorKey.currentContext!
                .pop<bool>(true),
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
