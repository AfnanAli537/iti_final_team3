class ImageModel {
  final String url;
  final String title;
  final String description;
  final String ?id;
  ImageModel({
    required this.url,
    required this.title,
    required this.description,
    this.id
  });

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      id:map['id']??'',
      url: map['url'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
    );
  }
}
