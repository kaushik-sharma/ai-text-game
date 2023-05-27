import '../../routes/routes.dart';

class UiHelpers {
  static void hideKeyboard() {
    kNavigatorKey.currentState?.focusNode.unfocus();
  }
}
