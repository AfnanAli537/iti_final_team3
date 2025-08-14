// ignore_for_file: use_super_parameters

part of 'login_bloc.dart';

class LoginState {
  final bool isPasswordVisible;
  const LoginState({this.isPasswordVisible = false});
}

class LoginInitialState extends LoginState {
  const LoginInitialState({bool isPasswordVisible = false}) : super(isPasswordVisible: isPasswordVisible);
}

class LoginLoadingState extends LoginState {
  const LoginLoadingState({bool isPasswordVisible = false}) : super(isPasswordVisible: isPasswordVisible);
}

class LoginSuccessState extends LoginState {
  final User user;

  LoginSuccessState(this.user, {bool isPasswordVisible = false}) : super(isPasswordVisible: isPasswordVisible);
}

class LoginFailureState extends LoginState {
  final String error;

  LoginFailureState(this.error,{bool isPasswordVisible = false}) : super(isPasswordVisible: isPasswordVisible);
}
final class LogoutState extends LoginState {}

final class LoginResetPasswordState extends LoginState {}
