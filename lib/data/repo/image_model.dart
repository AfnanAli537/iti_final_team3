class ImageModel {
  final String url;
  final String title;
  final String description;

  ImageModel({
    required this.url,
    required this.title,
    required this.description,
  });

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      url: map['url'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
    );
  }
}
