import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_team3/data/models/auth_repo.dart';
import 'package:iti_final_team3/utils/app_strings.dart';
import 'package:iti_final_team3/utils/form_validator.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepo _authRepo;
  SignUpBloc(this._authRepo) : super(SignUpInitialState()) {
    on<SignUpSubmittedEvent>(_onSignUpSubmitted);
    on<SignUpReset>(_onSignUpReset);
    on<InitiSingUpScreenEvent>(_onSignUpIniti);
    on<ToggleVisibilityEvent>(_onToggleVisibilityEvent);

  }

  Future<void> _onSignUpSubmitted(
      SignUpSubmittedEvent event, Emitter<SignUpState> emit) async {
    emit(SignUpLoadingState());
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
          emit(SignUpSuccessState(userName: user.displayName ?? AppStrings.anonymousUser));
        } else {
          emit(SignUpFailureState(AppStrings.faildSign));
        }
      }
    } on FirebaseAuthException catch (e) {
      emit(SignUpFailureState(e.toString()));
    }
  }

  void _onSignUpReset(SignUpReset event, Emitter<SignUpState> emit) {
    emit(SignUpInitialState());
  }

  void _onSignUpIniti(InitiSingUpScreenEvent event, Emitter<SignUpState> emit) {
    emit(SignUpInitialState());
  }
  void _onToggleVisibilityEvent(
      ToggleVisibilityEvent event, Emitter<SignUpState> emit) {
    final currentState = state;
    final isVisible = !(currentState.isPasswordVisible);
    emit(SignUpInitialState(isPasswordVisible: isVisible));
  }
}
