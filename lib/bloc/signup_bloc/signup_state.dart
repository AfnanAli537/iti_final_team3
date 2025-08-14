part of 'signup_bloc.dart';

abstract class SignUpState {
  final bool isPasswordVisible;
  const SignUpState({this.isPasswordVisible = false});

}

class SignUpInitialState extends SignUpState {
  const SignUpInitialState({super.isPasswordVisible});
}

class SignUpLoadingState extends SignUpState {
  const SignUpLoadingState({super.isPasswordVisible});
}

class SignUpSuccessState extends SignUpState {
  final String userName;

  SignUpSuccessState({required this.userName, super.isPasswordVisible});
}

class SignUpFailureState extends SignUpState {
  final String error;

  SignUpFailureState(this.error,{super.isPasswordVisible});
}
