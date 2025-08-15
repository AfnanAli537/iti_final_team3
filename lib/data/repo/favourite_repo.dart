import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iti_final_team3/data/repo/image_model.dart';

class FavoriteRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addToFavorites(String userId, ImageModel image) async {
    await firestore.collection('users').doc(userId).collection('favorites').add(
      {
        'url': image.url,
        'title': image.title,
        'description': image.description,
      },
    );
  }

  Future<void> removeFromFavorites(String userId, String imageUrl) async {
    final snapshot = await firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .where('url', isEqualTo: imageUrl)
        .get();

    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  Stream<List<ImageModel>> fetchFavorites(String userId) {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ImageModel.fromMap(doc.data()))
              .toList(),
        );
  }
}