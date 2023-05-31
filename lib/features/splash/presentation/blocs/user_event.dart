part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class CreateUserEvent extends UserEvent {
  const CreateUserEvent();

  @override
  List<Object> get props => [];
}
