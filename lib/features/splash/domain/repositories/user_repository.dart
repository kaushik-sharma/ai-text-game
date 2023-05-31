import 'package:ai_text_game/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract class UserRepository {
  Future<Either<Failure, NoParams>> createUser();
}
