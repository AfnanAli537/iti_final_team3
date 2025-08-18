// related_images_grid.dart
import 'package:flutter/material.dart';
import 'package:iti_final_team3/data/repo/image_repo.dart';
import 'package:iti_final_team3/screens/details_screen.dart';
import 'package:iti_final_team3/utils/app_strings.dart';
import 'package:iti_final_team3/widget/show_toast.dart';

class ImagesGridView extends StatelessWidget {
  final List<dynamic> allImages;
  final imageService = ImageRepository();

  ImagesGridView({
    super.key,
    this.allImages = const [],
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: allImages.length,
      itemBuilder: (context, i) {
        final imageUrl = allImages[i];
        return GestureDetector(
          onTap: () async {
            final imageModel =
                await imageService.fetchImageModelByUrl(imageUrl);
            if (imageModel != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailsPage(
                    image: imageModel,
                    images: allImages,
                  ),
                ),
              );
            } else {
              AppToast.showToast(AppStrings.detailsNotFound, Colors.red);
            }
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
              errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
            ),
          ),
        );
      },
    );
  }
}
