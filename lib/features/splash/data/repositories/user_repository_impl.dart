import 'package:ai_text_game/core/device/device_info.dart';
import 'package:ai_text_game/core/errors/exceptions.dart';
import 'package:ai_text_game/core/errors/failures.dart';
import 'package:ai_text_game/core/network/network_info.dart';
import 'package:ai_text_game/core/usecases/usecase.dart';
import 'package:ai_text_game/features/splash/data/datasources/user_datasource.dart';
import 'package:ai_text_game/features/splash/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource dataSource;
  final NetworkInfo networkInfo;
  final DeviceInfo deviceInfo;

  const UserRepositoryImpl({
    required this.dataSource,
    required this.networkInfo,
    required this.deviceInfo,
  });

  @override
  Future<Either<Failure, NoParams>> createUser() async {
    try {
      final bool isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        return const Left(InternetFailure(internetFailureMessage));
      }

      final String deviceId = await deviceInfo.deviceId;

      final NoParams result = await dataSource.createUser(deviceId);
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
