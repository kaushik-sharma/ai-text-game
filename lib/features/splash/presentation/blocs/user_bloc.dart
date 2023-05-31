import 'dart:async';

import 'package:ai_text_game/core/usecases/usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/create_user_usecase.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final CreateUserUseCase createUserUseCase;

  UserBloc(this.createUserUseCase) : super(UserInitial()) {
    on<CreateUserEvent>(_onCreateUserEvent);
  }

  Future<void> _onCreateUserEvent(
      CreateUserEvent event, Emitter<UserState> emit) async {
    emit(const CreatingUserState());

    final failureOrSuccess = await createUserUseCase(const NoParams());
    failureOrSuccess.fold<void>(
      (left) => emit(UserCreatedFailureState(left.message)),
      (right) => emit(const UserCreatedSuccessState()),
    );
  }
}
