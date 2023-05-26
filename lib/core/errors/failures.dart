import 'package:equatable/equatable.dart';

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

const String serverFailureMessage = 'Server failure occurred.';
const String cacheFailureMessage = 'Cache failure occurred.';
const String generalFailureMessage = 'Some failure occurred.';
const String internetFailureMessage = 'No Internet connection.';
