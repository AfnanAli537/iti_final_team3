part of 'signup_bloc.dart';

abstract class SignUpEvent {}

class SignUpSubmittedEvent extends SignUpEvent {
  final String email;
  final String password;
  final String confirmPassword;
  final String name;

  SignUpSubmittedEvent({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.name,
  });
}

class SignUpReset extends SignUpEvent {}

class InitiSingUpScreenEvent extends SignUpEvent {}
///
///
class ToggleVisibilityEvent extends SignUpEvent {}
