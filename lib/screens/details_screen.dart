import 'package:flutter/material.dart';
import 'package:iti_final_team3/data/repo/image_model.dart';
import 'package:iti_final_team3/data/repo/image_repo.dart';
import 'package:iti_final_team3/screens/heart_icon.dart';
import 'package:iti_final_team3/widget/grid_view.dart';

class DetailsPage extends StatelessWidget {
  final ImageModel image;
  final imageService = ImageRepository();
  final List<dynamic> images;
  DetailsPage({super.key, required this.image, this.images = const []});

  @override
  Widget build(BuildContext context) {
    final otherImages = images.where((url) => url != image.url).toList();
    return Scaffold(
      appBar: AppBar(title: Text(image.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                image.url,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        image.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      //الجزء بتاع eman
                      LikeButton(image: image),
                    ],
                  ),
                  Text(
                    image.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ImagesGridView(allImages: otherImages),
            ),
          ],
        ),
      ),
    );
  }
}
