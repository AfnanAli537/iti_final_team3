import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_team3/data/models/auth_repo.dart';
import 'package:iti_final_team3/utils/app_strings.dart';
import 'package:iti_final_team3/utils/form_validator.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepo _authRepo;
  SignUpBloc(this._authRepo) : super(SignUpInitial()) {
    on<SignUpSubmittedEvent>(_onSignUpSubmitted);
    on<SignUpReset>(_onSignUpReset);
    on<InitiSingUpScreenEvent>(_onSignUpIniti);
  }

  Future<void> _onSignUpSubmitted(
      SignUpSubmittedEvent event, Emitter<SignUpState> emit) async {
    emit(SignUpLoading());
    await Future.delayed(const Duration(seconds: 2));
    try {
      final emailError = FormValidator.validateEmail(event.email);
      final passwordError = FormValidator.validatePassword(event.password);
      final confirmPasswordError = FormValidator.validateConfirmPassword(
          event.password, event.confirmPassword);

      if (emailError == null &&
          passwordError == null &&
          confirmPasswordError == null) {
        final user = await _authRepo.signUpWithEmailAndPassword(
          email: event.email,
          password: event.password,
          name: event.name,
        );

        if (user != null) {
          emit(SignUpSuccess(userName: user.displayName ?? " "));
        } else {
          emit(SignUpFailure(AppStrings.faildSign));
        }
      }
    } catch (e) {
      emit(SignUpFailure("Something went wrong. ${e.toString()}"));
    }
  }

  void _onSignUpReset(SignUpReset event, Emitter<SignUpState> emit) {
    emit(SignUpInitial());
  }

  void _onSignUpIniti(InitiSingUpScreenEvent event, Emitter<SignUpState> emit) {
    emit(SignUpInitial());
  }
}
