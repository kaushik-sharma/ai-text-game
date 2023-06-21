import 'package:ai_text_game/core/device/device_info.dart';
import 'package:ai_text_game/core/errors/exceptions.dart';
import 'package:ai_text_game/core/errors/failures.dart';
import 'package:ai_text_game/core/network/network_info.dart';
import 'package:ai_text_game/features/game/data/datasources/game_datasource.dart';
import 'package:ai_text_game/features/game/domain/entities/message_entity.dart';
import 'package:ai_text_game/features/game/domain/repositories/game_repository.dart';
import 'package:dartz/dartz.dart';

import '../models/message_model.dart';

class GameRepositoryImpl implements GameRepository {
  final GameDataSource dataSource;
  final NetworkInfo networkInfo;
  final DeviceInfo deviceInfo;

  const GameRepositoryImpl({
    required this.dataSource,
    required this.networkInfo,
    required this.deviceInfo,
  });

  @override
  Future<Either<Failure, MessageModel>> sendMessage(
      List<MessageEntity> messages) async {
    try {
      final bool isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        return const Left(InternetFailure(internetFailureMessage));
      }

      final String deviceId = await deviceInfo.deviceId;

      final result = await dataSource.sendMessage(deviceId, messages);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(serverFailureMessage));
    } on CacheException {
      return const Left(CacheFailure(cacheFailureMessage));
    } catch (e) {
      return const Left(GeneralFailure(generalFailureMessage));
    }
  }
}
