import 'package:shared_preferences/shared_preferences.dart';

import '../../features/game/data/models/message_model.dart';
import '../../features/game/domain/entities/message_entity.dart';
import '../constants/app_data.dart';
import '../constants/storage_keys.dart';

class StorageHelpers {
  static Future<void> saveGame(
      SharedPreferences instance, GameData gameData) async {
    await instance.setString(kStorageKeyTheme, gameData.theme);

    final List<String> jsonStrings = _convertToModels(gameData.messages)
        .map((message) => message.toJson(message.toMap()))
        .toList();
    await instance.setStringList(kStorageKeyMessages, jsonStrings);
  }

  static Future<GameData?> getSavedGame(SharedPreferences instance) async {
    final String? theme = instance.getString(kStorageKeyTheme);

    final List<String>? jsonMessages =
        instance.getStringList(kStorageKeyMessages);

    if (theme == null || jsonMessages == null || jsonMessages.isEmpty) {
      return null;
    }

    final List<MessageModel> messageModels =
        jsonMessages.map((message) => MessageModel.fromJson(message)).toList();

    return GameData(theme, messageModels);
  }

  static Future<void> resetGame(SharedPreferences instance) async {
    await instance.clear();
  }

  static List<MessageModel> _convertToModels(List<MessageEntity> messages) {
    return messages
        .map(
          (message) => MessageModel(
            id: message.id,
            role: message.role,
            content: message.content,
          ),
        )
        .toList();
  }
}
