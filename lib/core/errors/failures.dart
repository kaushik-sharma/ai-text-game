import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../constants/app_values.dart';
import '../network/network_info.dart';
import 'exceptions.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);

  @override
  List<Object> get props => [message];
}

class InternetFailure extends Failure {
  const InternetFailure(super.message);

  @override
  List<Object> get props => [message];
}

class GeneralFailure extends Failure {
  const GeneralFailure(super.message);

  @override
  List<Object> get props => [message];
}

Future<Either<Failure, T>> kRepositoryImpl<T, P>({
  required NetworkInfo networkInfo,
  required Future<T> Function(P) callback,
  required P callbackParam,
}) async {
  try {
    final bool isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return const Left(InternetFailure(kInternetFailureMessage));
    }

    final T result = await callback(callbackParam);
    return Right(result);
  } on CacheException {
    return const Left(CacheFailure(kCacheFailureMessage));
  } on ServerException {
    return const Left(ServerFailure(kServerFailureMessage));
  } on InternetException {
    return const Left(InternetFailure(kInternetFailureMessage));
  } catch (e) {
    return const Left(GeneralFailure(kGeneralFailureMessage));
  }
}
