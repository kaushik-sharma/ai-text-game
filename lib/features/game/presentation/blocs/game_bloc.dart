import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_data.dart';
import '../../../../core/constants/enums.dart';
import '../../data/models/message_model.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/usecases/send_message_usecase.dart';

part 'game_event.dart';
part 'game_state.dart';

bool shouldAnimate = false;

class GameBloc extends Bloc<GameEvent, GameState> {
  final SendMessageUseCase sendMessageUseCase;

  GameBloc({required this.sendMessageUseCase})
      : super(const GameInitialState()) {
    on<SendMessageEvent>(_onSendMessageEvent);
    on<InitializeGameEvent>(_onInitializeGameEvent);
    on<AnimationCompleteEvent>(_onAnimationCompleteEvent);
  }

  Future<void> _onSendMessageEvent(
      SendMessageEvent event, Emitter<GameState> emit) async {
    final content = event.messageContent.trim();
    if (content.isEmpty) {
      emit(const InputInvalidState());
      return;
    }

    final userMessage = _getUserMessage(content);

    emit(InputValidState(userMessage));

    final failureOrSuccess = await sendMessageUseCase(
      GameData(event.theme, [userMessage, ...event.prevMessages]),
    );
    failureOrSuccess.fold<void>(
      (left) => emit(ChatCompletionFailureState(left.message)),
      (right) {
        shouldAnimate = true;
        emit(ChatCompletionSuccessState(right));
      },
    );
  }

  Future<void> _onInitializeGameEvent(
      InitializeGameEvent event, Emitter<GameState> emit) async {
    final content = 'Start a text adventure game with ${event.theme} theme. '
        'The game should start with an initial setting. '
        'After this the player should be presented with 3 options to choose from, '
        'and their choice should determine the direction in which the story proceeds. '
        'The presented options should be concise. '
        'Re-ask the player for input if the player input is not in the presented options.';

    final userMessage = _getUserMessage(content);

    emit(InputValidState(userMessage));

    final failureOrSuccess = await sendMessageUseCase(
      GameData(event.theme, [userMessage]),
    );
    failureOrSuccess.fold<void>(
      (left) => emit(ChatCompletionFailureState(left.message)),
      (right) {
        shouldAnimate = true;
        emit(ChatCompletionSuccessState(right));
      },
    );
  }

  void _onAnimationCompleteEvent(
      AnimationCompleteEvent event, Emitter<GameState> emit) {
    shouldAnimate = false;
    emit(const AnimationCompleteState());
  }

  MessageModel _getUserMessage(String content) {
    return MessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      role: Role.user,
      content: content,
    );
  }
}
