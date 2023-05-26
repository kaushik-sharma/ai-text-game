part of 'game_bloc.dart';

abstract class GameState extends Equatable {
  const GameState();
}

class GameInitialState extends GameState {
  const GameInitialState();

  @override
  List<Object> get props => [];
}

class InputValidState extends GameState {
  final MessageEntity message;

  const InputValidState(this.message);

  @override
  List<Object> get props => [message];
}

class InputInvalidState extends GameState {
  const InputInvalidState();

  @override
  List<Object> get props => [];
}

class ChatCompletionSuccessState extends GameState {
  final MessageEntity message;

  const ChatCompletionSuccessState(this.message);

  @override
  List<Object> get props => [message];
}

class ChatCompletionFailureState extends GameState {
  final String error;

  const ChatCompletionFailureState(this.error);

  @override
  List<Object> get props => [error];
}
