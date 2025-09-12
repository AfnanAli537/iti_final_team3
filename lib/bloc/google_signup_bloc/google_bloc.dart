import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_team3/data/models/auth_repo.dart';
part 'google_event.dart';
part 'google_state.dart';


class GoogleSignupBloc extends Bloc<GoogleSignupEvent, GoogleSignupState> {
  final AuthRepo authRepository;

  GoogleSignupBloc(this.authRepository) : super(GoogleSignupInitial()) {
    on<GoogleSignInRequested>((event, emit) async {
      emit(GoogleSignInLoading());
      try {
        final user = await authRepository.signInWithGoogle();

        if (user == null) {
          emit( GoogleSignInFailure("Google sign-in was cancelled"));
          return;
        }

        emit(GoogleSignInSuccess());
      } catch (e) {
        emit(GoogleSignInFailure(e.toString()));
      }
    });
  }
}