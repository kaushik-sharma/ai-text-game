part of 'game_bloc.dart';

@freezed
class GameEvent with _$GameEvent {
  const factory GameEvent.initializeGame(String theme) = _InitializeGame;

  const factory GameEvent.sendMessage(String theme,
      List<MessageEntity> prevMessages, String messageContent) = _SendMessage;

  const factory GameEvent.animationComplete() = _AnimationComplete;
}
