import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../presentation/blocs/game_bloc.dart';
import '../entities/message_entity.dart';

abstract class GameRepository {
  Future<Either<Failure, MessageEntity>> sendMessage(GameData gameData);
}
