part of 'signup_bloc.dart';

abstract class SignUpState {
  final bool isPasswordVisible;
  const SignUpState({this.isPasswordVisible = false});

}

class SignUpInitialState extends SignUpState {
  const SignUpInitialState({bool isPasswordVisible = false}) : super(isPasswordVisible: isPasswordVisible);
}

class SignUpLoadingState extends SignUpState {
  const SignUpLoadingState({bool isPasswordVisible = false}) : super(isPasswordVisible: isPasswordVisible);
}

class SignUpSuccessState extends SignUpState {
  final String userName;

  SignUpSuccessState({required this.userName, bool isPasswordVisible = false}) : super(isPasswordVisible: isPasswordVisible);
}

class SignUpFailureState extends SignUpState {
  final String error;

  SignUpFailureState(this.error,{bool isPasswordVisible = false}) : super(isPasswordVisible: isPasswordVisible);
}
