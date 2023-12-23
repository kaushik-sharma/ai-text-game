part of 'game_bloc.dart';

@freezed
class GameState with _$GameState {
  const factory GameState.initial() = _Initial;

  const factory GameState.inputValid(MessageEntity message) = _InputValid;

  const factory GameState.inputInvalid() = _InputInvalid;

  const factory GameState.chatCompletionSuccess(MessageEntity message) =
      _ChatCompletionSuccess;

  const factory GameState.chatCompletionFailure(String error) =
      _ChatCompletionFailure;

  const factory GameState.gameSaveSuccess() = _GameSaveSuccess;
}
