import 'package:ai_text_game/core/errors/exceptions.dart';
import 'package:ai_text_game/core/errors/failures.dart';
import 'package:ai_text_game/features/game/data/datasources/game_datasource.dart';
import 'package:ai_text_game/features/game/domain/entities/message_entity.dart';
import 'package:ai_text_game/features/game/domain/repositories/game_repository.dart';
import 'package:dartz/dartz.dart';

import '../models/message_model.dart';

class GameRepositoryImpl implements GameRepository {
  final GameDataSource dataSource;

  const GameRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<Either<Failure, MessageModel>> sendMessage(
      List<MessageEntity> messages) async {
    try {
      final result = await dataSource.sendMessage(messages);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure(serverFailureMessage));
    } on CacheException {
      return Left(CacheFailure(cacheFailureMessage));
    } on InternetException {
      return Left(InternetFailure(internetFailureMessage));
    } catch (e) {
      return Left(GeneralFailure(generalFailureMessage));
    }
  }
}
