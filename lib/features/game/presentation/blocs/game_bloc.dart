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
}
