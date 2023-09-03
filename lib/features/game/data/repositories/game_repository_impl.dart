import 'package:dartz/dartz.dart';

import '../../../../core/constants/app_data.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/storage/storage.dart';
import '../../domain/repositories/game_repository.dart';
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
    return await kRepositoryImpl<MessageModel, GameData>(
      networkInfo: networkInfo,
      callback: dataSource.sendMessage,
      callbackParam: gameData,
    );
  }
}
