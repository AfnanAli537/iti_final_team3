// ignore_for_file: use_super_parameters

part of 'login_bloc.dart';

class LoginState {

}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final User user;
  LoginSuccessState(this.user);}

class LoginFailureState extends LoginState {
  final String error;

  LoginFailureState(this.error);
}
final class LogoutState extends LoginState {}

final class LoginResetPasswordState extends LoginState {}
