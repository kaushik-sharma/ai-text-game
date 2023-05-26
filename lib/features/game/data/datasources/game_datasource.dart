import 'dart:convert';

import 'package:ai_text_game/core/errors/exceptions.dart';
import 'package:ai_text_game/features/game/data/models/message_model.dart';
import 'package:ai_text_game/features/game/domain/entities/message_entity.dart';
import 'package:dio/dio.dart';

import '../../../../core/network/network_info.dart';
import '../../../../injection_container.dart';

abstract class GameDataSource {
  Future<MessageModel> sendMessage(List<MessageEntity> messages);
}

class GameDataSourceImpl implements GameDataSource {
  @override
  Future<MessageModel> sendMessage(List<MessageEntity> messages) async {
    final nI = NetworkInfoImpl(connectionChecker: sl());
    final bool isConnected = await nI.isConnected;
    if (!isConnected) {
      throw InternetException();
    }

    final Dio dio = Dio();
    final Response<Map<String, dynamic>> response = await dio.post(
      'https://api.openai.com/v1/chat/completions',
      options: Options(
        headers: {
          'Authorization': '',
        },
      ),
      data: jsonEncode(
        {
          "model": "gpt-3.5-turbo",
          "messages": messages
              .map(
                (message) => {
                  'role': message.role.name,
                  'content': message.content,
                },
              )
              .toList(),
          "temperature": 1.0,
        },
      ),
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }

    final data = response.data?['choices'] as List<dynamic>?;
    if (data == null) {
      throw ServerException();
    }

    return MessageModel.fromMap(
      data[0] as Map<String, dynamic>,
    );
  }
}
