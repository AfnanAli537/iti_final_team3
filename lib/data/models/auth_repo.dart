import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iti_final_team3/data/repo/user_repository.dart';

class AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserRepository _userRepository = UserRepository();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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
      final user = credential.user;

      await user?.updateDisplayName(name);

      await user?.sendEmailVerification();
      await user?.reload();

      return _auth.currentUser;
    } on FirebaseAuthException catch (e) {
      debugPrint("Failed to sign up: ${e.message}");
      return null;
    }
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

      final user = credential.user;

      if (!user!.emailVerified) {
        await user.sendEmailVerification();
      } else {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (!userDoc.exists) {
          await _userRepository.createUserDocument(
            email: email,
            userId: user.uid,
            profileImageUrl:
                'https://cdn-icons-png.flaticon.com/512/847/847969.png',
          );
        }
      }
      return user;
    } on FirebaseAuthException catch (e) {
      debugPrint("Failed to sign in: ${e.message}");
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
    } catch (e) {
      debugPrint('failed to sign out with error---> ${e.toString()}');
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      if (await _userRepository.isEmailRegistered(email)) {
        await _auth.sendPasswordResetEmail(email: email);
      }
    } on FirebaseAuthException catch (e) {
      debugPrint("Failed to send password reset email: ${e.message}");
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      final User? user = userCredential.user;

      if (user == null) return null;

      await _userRepository.createUserDocument(
        email: user.email ?? "unknown",
        profileImageUrl: user.photoURL ??
            'https://cdn-icons-png.flaticon.com/512/847/847969.png',
        userId: user.uid,
      );

      return user;
    } catch (e) {
      print('Error during Google sign-in: $e');
      return null;
    }
  }
}
