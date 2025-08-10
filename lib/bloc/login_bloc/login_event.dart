part of 'login_bloc.dart';

class LoginEvent {
  const LoginEvent();
}

class LoginSubmittedEvent extends LoginEvent {
  final String email;
  final String password;

  LoginSubmittedEvent({
    required this.email,
    required this.password,
  });
}

class LoginReset extends LoginEvent {}

class LogoutEvent extends LoginEvent {}

class InitialLoginScreenEvent extends LoginEvent {}
