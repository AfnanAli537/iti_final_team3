import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:iti_final_team3/data/repos/user_repository.dart';
// import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthRepointerface {}

class AuthRepo extends AuthRepointerface {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreRepo _firestoreRepo = FirestoreRepo();

  Future<User?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credential.user?.updateDisplayName(name);
      _auth.currentUser?.sendEmailVerification();
      await credential.user?.reload();
      if (credential.user != null && credential.user!.emailVerified) {
      await _firestoreRepo.createUserDocumentIfNotExists(credential.user!);
    }
      // return credential.user;
      return _auth.currentUser;
    } on FirebaseAuthException catch (e) {
      debugPrint("Failed to sign up: ${e.message}");
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null && credential.user!.emailVerified) {
      await _firestoreRepo.createUserDocumentIfNotExists(credential.user!);
    }
      return credential.user;
    } on FirebaseAuthException catch (e) {
      debugPrint("Failed to sign in: ${e.message}");
      return null;
    }
  }


  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      debugPrint('failed to sign out with error---> ${e.toString()}');
    }
  }

  // Future<UserCredential?> signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //   if (googleUser == null) {
  //     debugPrint('Google sign-in aborted by user');
  //     return null;
  //   }
  //   final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      debugPrint("Failed to send password reset email: ${e.message}");
    }
  }
}
