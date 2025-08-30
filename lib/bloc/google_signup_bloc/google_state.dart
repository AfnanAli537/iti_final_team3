part of 'google_bloc.dart';

abstract class GoogleSignupState {}

class GoogleSignupInitial extends GoogleSignupState {}

class GoogleSignInLoading extends GoogleSignupState {}

class GoogleSignInSuccess extends GoogleSignupState {}

class GoogleSignInFailure extends GoogleSignupState {
  final String error;
  GoogleSignInFailure(this.error);
}
