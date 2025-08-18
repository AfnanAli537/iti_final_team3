import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:iti_final_team3/data/repo/user_repository.dart';

class AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserRepository _userRepository = UserRepository();

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

      // await _userRepository.createUserDocument(
      //   email: email,
      //   userId: user!.uid,
      //   profileImageUrl: 'https://cdn-icons-png.flaticon.com/512/847/847969.png', // default avatar
      // );

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
      if (await _userRepository.isEmailRegistered(email)) {
        await _auth.sendPasswordResetEmail(email: email);
      }
    } on FirebaseAuthException catch (e) {
      debugPrint("Failed to send password reset email: ${e.message}");
    }
  }
}
