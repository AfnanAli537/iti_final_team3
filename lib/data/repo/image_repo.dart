import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:iti_final_team3/data/repo/image_model.dart';

class ImageRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final String uploadPreset = 'pinsImages';
  final String cloudName = 'dja29crf4';

  Future<String> uploadImage(File file) async {
    final url =
        Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');

    final request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('file', file.path));
    request.fields['upload_preset'] = uploadPreset;

    final response = await request.send();
    final resStr = await response.stream.bytesToString();

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to upload image');
    }

    final data = jsonDecode(resStr);
    return data['secure_url'];
  }

  Future<void> saveImageData(
      String url, String title, String description) async {
    await firestore.collection('images').add({
      'url': url,
      'title': title,
      'description': description,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<String>> fetchImages() {
    return firestore
        .collection('images')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => doc['url'] as String).toList());
  }

  Stream<List<ImageModel>> fetchImageModels() {
    return firestore.collection('images').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => ImageModel.fromMap(doc.data())).toList());
  }

  Future<ImageModel?> fetchImageModelByUrl(String url) async {
    final query = await firestore
        .collection('images')
        .where('url', isEqualTo: url)
        .limit(1)
        .get();

    if (query.docs.isNotEmpty) {
      return ImageModel.fromMap(query.docs.first.data());
    }
    return null;
  }
}
