import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../domain/repositories/game_repository.dart';
import '../../presentation/blocs/game_bloc.dart';
import '../datasources/game_datasource.dart';
import '../models/message_model.dart';

class GameRepositoryImpl implements GameRepository {
  final GameDataSource dataSource;
  final NetworkInfo networkInfo;
  final Storage storage;

  const GameRepositoryImpl({
    required this.dataSource,
    required this.networkInfo,
    required this.storage,
  });

  @override
  Future<Either<Failure, MessageModel>> sendMessage(GameData gameData) async {
    try {
      final bool isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        throw const InternetException();
      }

      final MessageModel response = await dataSource.sendMessage(gameData);
      return Right(response);
    } on CacheException {
      return const Left(CacheFailure());
    } on ServerException {
      return const Left(ServerFailure());
    } on InternetException {
      return const Left(InternetFailure());
    } catch (e) {
      return const Left(GeneralFailure());
    }
  }
}
