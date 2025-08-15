import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iti_final_team3/data/repo/image_model.dart';


class FavoriteRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String _generateIdFromUrl(String url) {
    return md5.convert(utf8.encode(url)).toString();
  }

  Future<void> addToFavorites(String userId, ImageModel image) async {
    final docId = _generateIdFromUrl(image.url);
    await firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(docId)
        .set({
      'url': image.url,
      'title': image.title,
      'description': image.description,
    });
  }

  Future<void> removeFromFavorites(String userId, String imageUrl) async {
    final docId = _generateIdFromUrl(imageUrl);
    await firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(docId)
        .delete();
  }

  Stream<List<ImageModel>> fetchFavorites(String userId) {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => ImageModel.fromMap(doc.data())).toList());
  }
}

// import 'dart:convert';
// import 'package:crypto/crypto.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:heba/data/repo/image_model.dart';

// class FavouriteRepository {
//   final FirebaseFirestore firestore;
//   final String userId;

//   FavouriteRepository({required this.firestore, required this.userId});

//   /// Helper: Generate safe Firestore document ID from URL
//   String _generateIdFromUrl(String url) {
//     return md5.convert(utf8.encode(url)).toString();
//   }

//   /// Reference to current user's favourites collection
//   CollectionReference get favouritesCollection =>
//       firestore.collection('users').doc(userId).collection('favourites');

//   /// Get all favourites
//   Future<List<ImageModel>> getFavourites() async {
//     final snapshot = await favouritesCollection.get();
//     return snapshot.docs
//         .map((doc) => ImageModel.fromMap(doc.data() as Map<String, dynamic>))
//         .toList();
//   }

//   /// Add image to favourites
//   Future<void> addToFavourites(ImageModel image) async {
//     final docId = _generateIdFromUrl(image.url);
//     await favouritesCollection.doc(docId).set(image.toMap());
//   }

//   /// Remove image from favourites
//   Future<void> removeFromFavourites(String url) async {
//     final docId = _generateIdFromUrl(url);
//     await favouritesCollection.doc(docId).delete();
//   }

//   /// Check if image is in favourites
//   Future<bool> isFavourite(String url) async {
//     final docId = _generateIdFromUrl(url);
//     final doc = await favouritesCollection.doc(docId).get();
//     return doc.exists;
//   }

//   /// Factory method to create repository for current user
//   static FavouriteRepository createForCurrentUser() {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) {
//       throw Exception("User not logged in");
//     }
//     return FavouriteRepository(
//       firestore: FirebaseFirestore.instance,
//       userId: user.uid,
//     );
//   }
// }

// import 'dart:convert';
// import 'package:crypto/crypto.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:iti_final_team3/data/repo/image_model.dart';
// class FavouriteRepository {
//   final FirebaseFirestore firestore;
//   final String userId;

//   FavouriteRepository({required this.firestore, required this.userId});

//   /// Helper: Generate safe Firestore document ID from URL
//   String _generateIdFromUrl(String url) {
//     return md5.convert(utf8.encode(url)).toString();
//   }

//   /// Reference to current user's favourites collection
//   CollectionReference get favouritesCollection =>
//       firestore.collection('users').doc(userId).collection('favourites');

//   /// Get all favourites
//   Future<List<ImageModel>> getFavourites() async {
//     final snapshot = await favouritesCollection.get();
//     return snapshot.docs
//         .map((doc) => ImageModel.fromMap(doc.data() as Map<String, dynamic>))
//         .toList();
//   }

//   /// Add image to favourites
//   Future<void> addToFavourites(ImageModel image) async {
//     final docId = _generateIdFromUrl(image.url);
//     await favouritesCollection.doc(docId).set(image.toMap());
//   }

//   /// Remove image from favourites
//   Future<void> removeFromFavourites(String url) async {
//     final docId = _generateIdFromUrl(url);
//     await favouritesCollection.doc(docId).delete();
//   }

//   /// Check if image is in favourites
//   Future<bool> isFavourite(String url) async {
//     final docId = _generateIdFromUrl(url);
//     final doc = await favouritesCollection.doc(docId).get();
//     return doc.exists;
//   }

//   /// Factory method to create repository for current user
//   static FavouriteRepository createForCurrentUser() {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) {
//       throw Exception("User not logged in");
//     }
//     return FavouriteRepository(
//       firestore: FirebaseFirestore.instance,
//       userId: user.uid,
//     );
//   }
// }
