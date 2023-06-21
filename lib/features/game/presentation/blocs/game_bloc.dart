import 'dart:async';

import 'package:ai_text_game/features/game/domain/usecases/send_message_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/message_entity.dart';

part 'game_event.dart';
part 'game_state.dart';

bool shouldAnimate = false;

class GameBloc extends Bloc<GameEvent, GameState> {
  final SendMessageUseCase sendMessageUseCase;

  GameBloc({required this.sendMessageUseCase})
      : super(const GameInitialState()) {
    on<SendMessageEvent>(_onSendMessageEvent);
    on<InitializeGameEvent>(_onInitializeGameEvent);
  }

  Future<void> _onSendMessageEvent(
      SendMessageEvent event, Emitter<GameState> emit) async {
    shouldAnimate = false;

    final content = event.messageContent.trim();
    if (content.isEmpty) {
      emit(const InputInvalidState());
      return;
    }

    final userMessage = MessageEntity(role: Role.user, content: content);

    emit(InputValidState(userMessage));

    final failureOrSuccess = await sendMessageUseCase(
      [...event.prevMessages, userMessage],
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
    shouldAnimate = false;

    emit(const GameInitializingState());

    final content = 'Start a text adventure game with ${event.theme} theme. '
        'The game should start with an initial setting. '
        'After this the player should be presented with 3 options to choose from, '
        'and their choice should determine the direction in which the story proceeds. '
        'Do not proceed after the initial setting of the game without player input. '
        'Re-ask the player for input if the input is not in the presented options.';

    final userMessage = MessageEntity(role: Role.user, content: content);

    final failureOrSuccess = await sendMessageUseCase(
      [userMessage],
    );
    failureOrSuccess.fold<void>(
      (left) => emit(ChatCompletionFailureState(left.message)),
      (right) {
        shouldAnimate = true;
        emit(ChatCompletionSuccessState(right));
      },
    );
  }
}
