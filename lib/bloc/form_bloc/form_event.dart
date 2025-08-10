part of 'form_bloc.dart';

abstract class PasswordVisibilityEvent {
  const PasswordVisibilityEvent();
}

class TogglePasswordVisibilityEvent extends PasswordVisibilityEvent {}
