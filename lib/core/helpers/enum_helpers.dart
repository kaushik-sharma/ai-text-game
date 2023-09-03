import 'package:enum_to_string/enum_to_string.dart';

class EnumHelpers {
  static String? convertToString(dynamic enumItem) {
    try {
      return EnumToString.convertToString(enumItem, camelCase: true);
    } catch (e) {
      return null;
    }
  }

  static T? convertToEnum<T>(List<T> enumValues, String value) {
    try {
      return EnumToString.fromString(enumValues, value, camelCase: true);
    } catch (e) {
      return null;
    }
  }
}

enum Role {
  user,
  assistant,
}

enum ButtonMode {
  primary,
  secondary,
}
