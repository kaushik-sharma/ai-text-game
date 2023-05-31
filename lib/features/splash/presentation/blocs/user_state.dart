part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class CreatingUserState extends UserState {
  const CreatingUserState();

  @override
  List<Object> get props => [];
}

class UserCreatedSuccessState extends UserState {
  const UserCreatedSuccessState();

  @override
  List<Object> get props => [];
}

class UserCreatedFailureState extends UserState {
  final String message;

  const UserCreatedFailureState(this.message);

  @override
  List<Object> get props => [message];
}
