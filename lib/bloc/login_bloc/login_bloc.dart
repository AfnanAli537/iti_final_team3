import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iti_final_team3/data/models/auth_repo.dart';
import 'package:iti_final_team3/utils/app_strings.dart';
import 'package:iti_final_team3/utils/form_validator.dart';


part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepo _authRepo;

  LoginBloc(this._authRepo) : super(LoginInitial()) {
    on<LoginSubmittedEvent>(_onLoginSubmittedEvent);
    on<LoginReset>(_onLoginReset);
    on<LogoutEvent>(_onLogoutEvent);
  }

  Future<void> _onLoginSubmittedEvent(
      LoginSubmittedEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    try {
      final emailError = FormValidator.validateEmail(event.email);
      final passwordError = FormValidator.validatePassword(event.password);
      if (emailError == null && passwordError == null) {
        final user = await _authRepo.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        if (user != null) {
          emit(LoginSuccess(user));
        } else {
          emit(LoginFailure(AppStrings.faildLogin));
        }
      }
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

  void _onLoginReset(LoginReset event, Emitter<LoginState> emit) {
    emit(LoginInitial());
  }

  Future<void> _onLogoutEvent(
      LogoutEvent event, Emitter<LoginState> emit) async {
    try {
      await _authRepo.signOut();
      emit(LoginInitial());
    } catch (e) {
      emit(LoginFailure(AppStrings.faildLogout));
    }
  }
}
