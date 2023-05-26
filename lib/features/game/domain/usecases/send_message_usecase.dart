import 'package:ai_text_game/core/errors/failures.dart';
import 'package:ai_text_game/features/game/domain/entities/message_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecase.dart';
import '../repositories/game_repository.dart';

class SendMessageUseCase
    implements UseCase<MessageEntity, List<MessageEntity>> {
  final GameRepository repository;

  const SendMessageUseCase(this.repository);

  @override
  Future<Either<Failure, MessageEntity>> call(
      List<MessageEntity> params) async {
    return await repository.sendMessage(params);
  }
}
