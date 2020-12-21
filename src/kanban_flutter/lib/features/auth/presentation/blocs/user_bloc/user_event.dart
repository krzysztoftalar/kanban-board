part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends UserEvent {
  final String email;
  final String password;

  LoginEvent({
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class RegisterEvent extends UserEvent {
  final String userName;
  final String email;
  final String password;

  RegisterEvent({
    @required this.userName,
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [userName, email, password];
}

class CurrentUserEvent extends UserEvent {}

class LogoutEvent extends UserEvent {}
