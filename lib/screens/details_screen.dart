import 'package:flutter/material.dart';
import 'package:iti_final_team3/data/repo/image_model.dart';
import 'package:iti_final_team3/data/repo/image_repo.dart';
import 'package:iti_final_team3/screens/heart_icon.dart';
import 'package:iti_final_team3/utils/app_strings.dart';
import 'package:iti_final_team3/widget/show_toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_team3/bloc/favourite_bloc/favourite_bloc.dart';
import 'package:iti_final_team3/bloc/favourite_bloc/favourite_event.dart';
import 'package:iti_final_team3/bloc/favourite_bloc/favourite_state.dart';

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
                      LikeButton(
                        initialIsLiked:
                            context.select<FavouriteBloc, bool>((bloc) {
                          if (bloc.state is FavouriteLoaded) {
                            return (bloc.state as FavouriteLoaded)
                                .favourites
                                .any((fav) => fav.url == image.url);
                          }
                          return false;
                        }),
                        onChanged: (isLiked) {
                          if (isLiked) {
                            context
                                .read<FavouriteBloc>()
                                .add(AddFavourite(image));
                          } else {
                            context
                                .read<FavouriteBloc>()
                                .add(RemoveFavourite(image.url));
                          }
                        },
                      ),
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
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: otherImages.length,
                itemBuilder: (context, i) {
                  final imageUrl = otherImages[i];
                  return GestureDetector(
                    onTap: () async {
                      final imageModel =
                          await imageService.fetchImageModelByUrl(imageUrl);
                      if (imageModel != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                DetailsPage(image: imageModel, images: images),
                          ),
                        );
                      } else {
                        AppToast.showToast(
                            AppStrings.detailsNotFound, Colors.red);
                      }
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.broken_image),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
