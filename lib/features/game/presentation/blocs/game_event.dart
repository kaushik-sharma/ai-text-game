part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();
}

class SendMessageEvent extends GameEvent {
  final String theme;
  final List<MessageEntity> prevMessages;
  final String messageContent;

  const SendMessageEvent(this.theme, this.prevMessages, this.messageContent);

  @override
  List<Object> get props => [theme, prevMessages, messageContent];
}

class InitializeGameEvent extends GameEvent {
  final String theme;

  const InitializeGameEvent(this.theme);

  @override
  List<Object> get props => [theme];
}

class AnimationCompleteEvent extends GameEvent {
  const AnimationCompleteEvent();

  @override
  List<Object> get props => [];
}
