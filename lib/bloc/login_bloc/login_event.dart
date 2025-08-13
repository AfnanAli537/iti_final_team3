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
final class LoginSuccessEvent extends LoginEvent {}

final class LoginFailureEvent extends LoginEvent {
  final String error;
  LoginFailureEvent({required this.error});

}
///
///
class LoginResetEvent extends LoginEvent {}
///
///
class LogoutEvent extends LoginEvent {}

class InitialLoginScreenEvent extends LoginEvent {}
///
///
class ToggleVisibilityEvent extends LoginEvent {}
class ForgetPasswordEvent extends LoginEvent {
  final String email;
  ForgetPasswordEvent({required this.email});
}