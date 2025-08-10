import 'package:flutter_bloc/flutter_bloc.dart';
part 'form_event.dart';
part 'form_state.dart';

class PasswordVisibilityBloc
    extends Bloc<PasswordVisibilityEvent, PasswordVisibilityState> {
  PasswordVisibilityBloc() : super(PasswordVisibilityState(isoObscure: true)) {
    on<TogglePasswordVisibilityEvent>((event, emit) {
      emit(PasswordVisibilityState(isoObscure: !state.isoObscure));
    });
  }
}
