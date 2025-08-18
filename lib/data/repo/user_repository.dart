import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:iti_final_team3/data/repo/user_model.dart';

class UserRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  final String uploadPreset = 'pinsImages';
  final String cloudName = 'dja29crf4';

  String get currentUserId => auth.currentUser?.uid ?? '';

  Future<String> uploadProfileImage(File imageFile) async {
    final url =
        Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');

    final request = http.MultipartRequest('POST', url);
    request.files
        .add(await http.MultipartFile.fromPath('file', imageFile.path));
    request.fields['upload_preset'] = uploadPreset;

    final response = await request.send();
    final resStr = await response.stream.bytesToString();

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to upload profile image');
    }

    final data = jsonDecode(resStr);
    return data['secure_url'];
  }

  Future<void> createUserDocument({
    required String email,
    required String userId,
    String? profileImageUrl,
  }) async {
    await firestore.collection('users').doc(userId).set({
      'email': email,
      'profileImageUrl': profileImageUrl ??
          'https://cdn-icons-png.flaticon.com/512/847/847969.png',
    });
  }

  Future<void> updateUserProfile({
    String? userId,
    String? profileImageUrl,
  }) async {
    final uid = userId ?? currentUserId;
    final updateData = <String, dynamic>{};

    if (profileImageUrl != null) updateData['profileImageUrl'] = profileImageUrl;
    await firestore.collection('users').doc(uid).update(updateData);
  }

  Future<String?> getProfileImageUrl({String? userId}) async {
    final doc = await firestore.collection('users').doc(userId).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data()!).profileImageUrl;
    }
    return null;
  }

  Future<UserModel?> getUserData({String? userId}) async {
    final uid = userId ?? currentUserId;
    if (uid.isEmpty) return null;

    final doc = await firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data()!);
    }
    return null;
  }

  Future<bool> isEmailRegistered(String email) async {
    final normalizedEmail = email.toLowerCase();
    final query = await firestore
        .collection('users')
        .where('email', isEqualTo: normalizedEmail)
        .limit(1)
        .get();

    return query.docs.isNotEmpty;
  }
}
