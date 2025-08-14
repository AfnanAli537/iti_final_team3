import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Create user document when verified (only if doesn't exist)
  Future<void> createUserDocumentIfNotExists(User user) async {
    final docRef = _firestore.collection('users').doc(user.uid);
    final docSnapshot = await docRef.get();

    if (!docSnapshot.exists) {
      await docRef.set({
        'name': user.displayName ?? '',
        'email': user.email,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  /// Add to favorites
  Future<void> addFavorite(String userId, String imageId) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(imageId)
        .set({
      'addedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Remove from favorites
  Future<void> removeFavorite(String userId, String imageId) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(imageId)
        .delete();
  }

  /// Get all favorites
  Stream<List<String>> getFavorites(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.id).toList());
  }
}
