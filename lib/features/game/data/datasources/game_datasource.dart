import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/core.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/message_entity.dart';
import '../../presentation/blocs/game_bloc.dart';
import '../models/message_model.dart';

abstract class GameDataSource {
  Future<MessageModel> sendMessage(GameData gameData);
}

class GameDataSourceImpl implements GameDataSource {
  final Dio dio;
  final SharedPreferences sharedPreferences;

  const GameDataSourceImpl({
    required this.dio,
    required this.sharedPreferences,
  });

  @override
  Future<MessageModel> sendMessage(GameData gameData) async {
    await StorageHelpers.saveGame(sharedPreferences, gameData);
    sl<GameBloc>().add(GameEvent.saveGame(gameData));

    // final String encodedMessages = await compute<List<MessageEntity>, String>(_encodeMessages, gameData.messages);

    // final Response<Map<String, dynamic>> response =
    //     await dio.get<Map<String, dynamic>>(
    //   kChatCompletionUrl,
    //   data: encodedMessages,
    // );

    // final int? statusCode = response.statusCode;
    // if (statusCode == null || statusCode != 200) {
    //   throw const ServerException();
    // }

    // final Map<String, dynamic> data =
    //     response.data!['data'] as Map<String, dynamic>;

    // final MessageModel receivedMessage = MessageModel.fromJson(data);
    final MessageModel receivedMessage = MessageModel(
      role: Role.assistant,
      content:
          '${DateTime.now().millisecondsSinceEpoch} Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum ullamcorper ullamcorper ultrices. Mauris malesuada ipsum eu metus dignissim dictum. Quisque erat neque, mollis eu vulputate finibus, imperdiet ut odio. Aliquam et justo vel lectus feugiat feugiat. Duis sed accumsan ligula, eget tempor leo. Maecenas eget justo interdum, pharetra mi id, commodo erat. Maecenas convallis malesuada nulla, sed fermentum diam gravida in.',
    );
    final GameData newGame =
        GameData(gameData.theme, [receivedMessage, ...gameData.messages]);

    await StorageHelpers.saveGame(sharedPreferences, newGame);
    sl<GameBloc>().add(GameEvent.saveGame(newGame));

    return receivedMessage;
  }

  static String _encodeMessages(List<MessageEntity> messages) {
    return jsonEncode({
      'messages': messages.reversed
          .map(
            (message) => {
              'role': message.role.name,
              'content': message.content,
            },
          )
          .toList(),
    });
  }
}
