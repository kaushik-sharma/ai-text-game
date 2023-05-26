import '../../app.dart';

class UiHelpers {
  static void hideKeyboard() {
    kNavigatorKey.currentState?.focusNode.unfocus();
  }
}
