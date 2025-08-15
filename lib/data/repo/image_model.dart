import 'package:equatable/equatable.dart';

class ImageModel extends Equatable {
  final String url;
  final String title;
  final String description;

  const ImageModel({
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

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'title': title,
      'description': description,
    };
  }

  @override
  List<Object?> get props => [url];
}




