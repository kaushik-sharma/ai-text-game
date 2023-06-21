import 'package:ai_text_game/features/game/domain/entities/message_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract class GameRepository {
  Future<Either<Failure, MessageEntity>> sendMessage(
      List<MessageEntity> messages);
}
