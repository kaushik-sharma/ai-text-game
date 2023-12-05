import 'package:dartz/dartz.dart';

import '../constants/app_values.dart';
import '../network/network_info.dart';
import 'exceptions.dart';

abstract class Failure {
  final String message;

  const Failure(this.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class InternetFailure extends Failure {
  const InternetFailure(super.message);
}

class GeneralFailure extends Failure {
  const GeneralFailure(super.message);
}

Future<Either<Failure, T>> kRepositoryImpl<T, P>({
  required NetworkInfo networkInfo,
  required Future<T> Function(P) callback,
  required P callbackParam,
}) async {
  const int maxTries = 3;
  int currentIteration = 0;
  late Either<Failure, T> failure;

  while (currentIteration < maxTries) {
    try {
      final bool isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        throw const InternetException();
      }

      final T result = await callback(callbackParam);
      return Right(result);
    } on CacheException {
      failure = const Left(CacheFailure(kCacheFailureMessage));
    } on ServerException {
      failure = const Left(ServerFailure(kServerFailureMessage));
    } on InternetException {
      failure = const Left(InternetFailure(kInternetFailureMessage));
    } catch (e) {
      failure = const Left(GeneralFailure(kGeneralFailureMessage));
    } finally {
      currentIteration++;
    }
  }

  return failure;
}
