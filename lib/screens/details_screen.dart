import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_team3/bloc/favourite_bloc/favourite_bloc.dart';
import 'package:iti_final_team3/bloc/favourite_bloc/favourite_event.dart';
import 'package:iti_final_team3/bloc/favourite_bloc/favourite_state.dart';
import 'package:iti_final_team3/data/repo/image_model.dart';
import 'package:iti_final_team3/data/repo/image_repo.dart';
import 'package:iti_final_team3/screens/heart_icon.dart';
import 'package:iti_final_team3/widget/show_toast.dart';


class DetailsPage extends StatelessWidget {
  final ImageModel image;
  final imageService = ImageRepository();
  final List<dynamic> images;
  DetailsPage({super.key, required this.image, required this.images});

  @override
  Widget build(BuildContext context) {

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
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      //الجزء بتاع eman 

                 LikeButton(
  initialIsLiked: context.select<FavouriteBloc, bool>((bloc) {
    if (bloc.state is FavouriteLoaded) {
      return (bloc.state as FavouriteLoaded)
          .favourites
          .any((fav) => fav.url == image.url);
    }
    return false;
  }),
  onChanged: (isLiked) {
    if (isLiked) {
      context.read<FavouriteBloc>().add(AddFavourite(image));
    } else {
      context.read<FavouriteBloc>().add(RemoveFavourite(image.url));
    }
  },
),
 


// LikeButton(
//   initialIsLiked: context.select<FavoriteBloc, bool>((bloc) {
//     if (bloc.state is FavoriteLoaded) {
//       return (bloc.state as FavoriteLoaded)
//           .favorites
//           .any((fav) => fav.url == image.url);
//     }
//     return false;
//   }),
//   onChanged: (isLiked) {
//     context.read<FavoriteBloc>().add(ToggleFavorite(image));
//   },
// ),

                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    image.description,
                    style: const TextStyle(fontSize: 16),
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
                itemCount: images.length,
                itemBuilder: (context, i) {
                  final imageUrl = images[i];
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
                        AppToast.showToast('Details not found', Colors.red);
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
