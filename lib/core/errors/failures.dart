abstract class Failure {
  final String message;

  const Failure(this.message);
}

class CacheFailure implements Failure {
  const CacheFailure();

  @override
  String get message => 'Cache failure occurred.';
}

class ServerFailure implements Failure {
  const ServerFailure();

  @override
  String get message => 'Server failure occurred.';
}

class InternetFailure implements Failure {
  const InternetFailure();

  @override
  String get message => 'No Internet connection.';
}

class GeneralFailure implements Failure {
  const GeneralFailure();

  @override
  String get message => 'Some failure occurred.';
}
