import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/message_model.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/usecases/send_message_usecase.dart';

part 'game_bloc.freezed.dart';
part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameData? savedGame;

  final SendMessageUseCase sendMessageUseCase;

  GameBloc({required this.sendMessageUseCase}) : super(const _Initial()) {
    on<_InitializeGame>(_onInitializeGameEvent);
    on<_SendMessage>(_onSendMessageEvent);
    on<_SaveGame>(_onSaveGame);
  }

  Future<void> _onInitializeGameEvent(
      _InitializeGame event, Emitter<GameState> emit) async {
    final content = 'Start a text adventure game with ${event.theme} theme. '
        'The game should start with an initial setting. '
        'After this the player should be presented with 3 options to choose from, '
        'and their choice should determine the direction in which the story proceeds. '
        'The presented options should be concise. '
        'Re-ask the player for input if the player input is not in the presented options.';

    final userMessage = _getUserMessage(content);

    emit(_InputValid(userMessage));

    final failureOrSuccess = await sendMessageUseCase(
      GameData(event.theme, [userMessage]),
    );
    failureOrSuccess.fold<void>(
      (left) => emit(_ChatCompletionFailure(left.message)),
      (right) => emit(_ChatCompletionSuccess(right)),
    );
  }

  Future<void> _onSendMessageEvent(
      _SendMessage event, Emitter<GameState> emit) async {
    final content = event.messageContent.trim();
    if (content.isEmpty) {
      emit(const _InputInvalid());
      return;
    }

    final userMessage = _getUserMessage(content);

    emit(_InputValid(userMessage));

    final failureOrSuccess = await sendMessageUseCase(
      GameData(event.theme, [userMessage, ...event.prevMessages]),
    );
    failureOrSuccess.fold<void>(
      (left) => emit(_ChatCompletionFailure(left.message)),
      (right) => emit(_ChatCompletionSuccess(right)),
    );
  }

  MessageModel _getUserMessage(String content) {
    return MessageModel(
      role: Role.user,
      content: content,
    );
  }

  void _onSaveGame(_SaveGame event, Emitter<GameState> emit) {
    savedGame = event.gameData;
    emit(const _GameSaveSuccess());
  }
}

class GameData {
  final String theme;
  final List<MessageEntity> messages;

  const GameData(this.theme, this.messages);
}
