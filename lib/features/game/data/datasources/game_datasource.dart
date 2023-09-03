import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_data.dart';
import '../../../../core/constants/app_urls.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/helpers/storage_helpers.dart';
import '../models/message_model.dart';

abstract class GameDataSource {
  Future<MessageModel> sendMessage(GameData gameData);
}

class GameDataSourceImpl implements GameDataSource {
  final SharedPreferences sharedPreferences;

  const GameDataSourceImpl({
    required this.sharedPreferences,
  });

  @override
  Future<MessageModel> sendMessage(GameData gameData) async {
    await StorageHelpers.saveGame(
        sharedPreferences, GameData(gameData.theme, [...gameData.messages]));

    final Dio dio = Dio();
    final Response<Map<String, dynamic>> response =
        await dio.post<Map<String, dynamic>>(
      kChatCompletionUrl,
      data: jsonEncode({
        'messages': gameData.messages.reversed
            .map(
              (message) => {
                'role': message.role.name,
                'content': message.content,
              },
            )
            .toList(),
      }),
    );

    if (response.statusCode != 200) {
      throw const ServerException();
    }

    final MessageModel receivedMessage =
        MessageModel.fromMap(response.data as Map<String, dynamic>);

    await StorageHelpers.saveGame(sharedPreferences,
        GameData(gameData.theme, [receivedMessage, ...gameData.messages]));

    return receivedMessage;
  }
}
