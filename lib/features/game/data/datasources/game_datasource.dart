import 'dart:convert';

import 'package:ai_text_game/core/constants/urls.dart';
import 'package:ai_text_game/core/errors/exceptions.dart';
import 'package:ai_text_game/features/game/data/models/message_model.dart';
import 'package:ai_text_game/features/game/domain/entities/message_entity.dart';
import 'package:dio/dio.dart';

abstract class GameDataSource {
  Future<MessageModel> sendMessage(
      String deviceId, List<MessageEntity> messages);
}

class GameDataSourceImpl implements GameDataSource {
  @override
  Future<MessageModel> sendMessage(
      String deviceId, List<MessageEntity> messages) async {
    final Dio dio = Dio();
    final Response<Map<String, dynamic>> response = await dio.post(
      chatCompletionUrl,
      data: jsonEncode({
        'deviceId': deviceId,
        'messages': messages
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

    final data = response.data?['choices'] as List<dynamic>?;
    if (data == null) {
      throw const ServerException();
    }

    return MessageModel.fromMap(
      data[0] as Map<String, dynamic>,
    );
  }
}
