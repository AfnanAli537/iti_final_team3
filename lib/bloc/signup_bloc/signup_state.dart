part of 'signup_bloc.dart';

abstract class SignUpState {}

class SignUpInitialState extends SignUpState {
}

class SignUpLoadingState extends SignUpState {
}

class SignUpSuccessState extends SignUpState {
  final String userName;

  SignUpSuccessState({required this.userName});
}

class SignUpFailureState extends SignUpState {
  final String error;

  SignUpFailureState(this.error,);
}
