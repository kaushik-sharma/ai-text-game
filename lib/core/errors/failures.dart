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
