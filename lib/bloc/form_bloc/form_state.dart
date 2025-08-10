part of 'form_bloc.dart';

abstract class PasswordState {}

class PasswordVisibilityState extends PasswordState {
  final bool isoObscure;

  PasswordVisibilityState({required this.isoObscure});
}
