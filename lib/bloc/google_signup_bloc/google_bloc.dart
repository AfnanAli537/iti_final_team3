import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iti_final_team3/data/models/auth_repo.dart';

part 'google_event.dart';
part 'google_state.dart';

class GoogleSignupBloc extends Bloc<GoogleSignupEvent, GoogleSignupState> {
  final AuthRepo authRepository;

  GoogleSignupBloc(this.authRepository) : super(GoogleSignupInitial()) {
    on<GoogleSignInRequested>((event, emit) async {
      emit(GoogleSignInLoading());
      try {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        if (googleUser == null) {
          emit(GoogleSignInFailure("Google sign in aborted"));
          return;
        }

        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);

        emit(GoogleSignInSuccess());
      } catch (e) {
        emit(GoogleSignInFailure(e.toString()));
      }
    });
  }
}
