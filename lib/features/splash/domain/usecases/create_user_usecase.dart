import 'package:ai_text_game/core/errors/failures.dart';
import 'package:ai_text_game/core/usecases/usecase.dart';
import 'package:ai_text_game/features/splash/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class CreateUserUseCase implements UseCase<NoParams, NoParams> {
  final UserRepository repository;

  const CreateUserUseCase(this.repository);

  @override
  Future<Either<Failure, NoParams>> call(NoParams params) async {
    return await repository.createUser();
  }
}
