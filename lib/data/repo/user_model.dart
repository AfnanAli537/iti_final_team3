class UserModel {
  final String email;
  final String profileImageUrl;

  UserModel({
    required this.email,
    required this.profileImageUrl,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      profileImageUrl: map['profileImageUrl'] ?? 'https://cdn-icons-png.flaticon.com/512/847/847969.png',
    );
  }
}