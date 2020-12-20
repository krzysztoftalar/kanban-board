part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserAuthenticated extends UserState {
  final User user;

  UserAuthenticated({
    @required this.user,
  });

  @override
  List<Object> get props => [user];
}

class UserError extends UserState {
  final String message;

  UserError({
    @required this.message,
  });

  @override
  List<Object> get props => [message];
}
