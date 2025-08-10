part of 'signup_bloc.dart';

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final String userName;

  SignUpSuccess({required this.userName});
}

class SignUpFailure extends SignUpState {
  final String error;

  SignUpFailure(this.error);
}
