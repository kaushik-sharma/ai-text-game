import 'package:dartz/dartz.dart';

import '../../../../core/constants/app_data.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/message_entity.dart';
import '../repositories/game_repository.dart';

class SendMessageUseCase implements UseCase<MessageEntity, GameData> {
  final GameRepository repository;

  const SendMessageUseCase(this.repository);

  @override
  Future<Either<Failure, MessageEntity>> call(GameData params) async {
    return await repository.sendMessage(params);
  }
}
