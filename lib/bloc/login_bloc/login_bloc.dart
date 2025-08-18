import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iti_final_team3/data/models/auth_repo.dart';
import 'package:iti_final_team3/utils/app_strings.dart';
import 'package:iti_final_team3/utils/form_validator.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepo _authRepo;

  LoginBloc(this._authRepo) : super(LoginInitialState()) {
    on<LoginSubmittedEvent>(_onLoginSubmittedEvent);
    on<LoginResetEvent>(_onLoginReset);
    on<LogoutEvent>(_onLogoutEvent);
    on<ForgetPasswordEvent>(_onForgetPasswordEvent);
  }

  Future<void> _onLoginSubmittedEvent(
      LoginSubmittedEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());

    try {
      final emailError = FormValidator.validateEmail(event.email);
      final passwordError = FormValidator.validatePassword(event.password);
      if (emailError == null && passwordError == null) {
        final user = await _authRepo.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        if (user != null) {
          emit(LoginSuccessState(user));
        }
        // else if (!FirebaseAuth.instance.currentUser!.emailVerified) {
        //   emit(LoginFailureState(AppStrings.verifyEmail));
        // }
        else {
          emit(LoginFailureState(AppStrings.faildLogin));
        }
      }
    } catch (e) {
      emit(LoginFailureState(AppStrings.faildLogin));
    }
  }

  void _onLoginReset(LoginResetEvent event, Emitter<LoginState> emit) {
    emit(LoginInitialState());
  }

  Future<void> _onLogoutEvent(
      LogoutEvent event, Emitter<LoginState> emit) async {
    try {
      await _authRepo.signOut();
      emit(LogoutState());
    } catch (e) {
      emit(LoginFailureState(AppStrings.faildLogout));
    }
  }

  Future<void> _onForgetPasswordEvent(
      ForgetPasswordEvent event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoadingState());
      QuerySnapshot query = await FirebaseFirestore.instance
          .collection('users')
          .where("email", isEqualTo: event.email)
          .limit(1)
          .get();
      if (query.docs.isNotEmpty) {
        await _authRepo.sendPasswordResetEmail(event.email);
        emit(LoginResetPasswordState());
      }else{
        emit(LoginFailureState(AppStrings.emailNotRegistered));
      }
    } on FirebaseAuthException catch (e) {
      emit(LoginFailureState(AppStrings.faildResetPassword));
      debugPrint(e.toString());
    }
  }
}
