part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();
}

class SendMessageEvent extends GameEvent {
  final List<MessageEntity> prevMessages;
  final String messageContent;

  const SendMessageEvent(this.prevMessages, this.messageContent);

  @override
  List<Object> get props => [prevMessages, messageContent];
}
