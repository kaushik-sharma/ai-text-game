import 'package:dartz/dartz.dart';

import '../../../../core/constants/app_data.dart';
import '../../../../core/errors/failures.dart';
import '../entities/message_entity.dart';

abstract class GameRepository {
  Future<Either<Failure, MessageEntity>> sendMessage(GameData gameData);
}
