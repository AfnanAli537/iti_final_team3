import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:iti_final_team3/bloc/home_bloc/image_bloc.dart';
import 'package:iti_final_team3/data/repo/image_repo.dart';
import 'package:iti_final_team3/screens/details_screen.dart';
import 'package:iti_final_team3/utils/app_strings.dart';
import 'package:iti_final_team3/widget/show_toast.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final imageService = ImageRepository();

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.homeTitle),
      ),
      body: BlocBuilder<ImageBloc, ImageState>(
        builder: (context, state) {
          if (state is ImageLoading) {
            return Center(
              child: Lottie.asset(
                'assets/lottie/empty1.json',
              ),
            );
          } else if (state is ImageLoaded) {
            final images = state.images;

            return MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              padding: const EdgeInsets.all(8),
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
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.broken_image, size: 50),
                    ),
                  ),
                );
              },
            );
          } else if (state is ImageEmpty) {
            return const Center(child: Text(AppStrings.noImagesYet));
          } else if (state is ImageError) {
            return Center(child: Text('Error: ${state.message}'));
          }

          return const Center(child: Text(AppStrings.welcome));
        },
      ),
    );
  }
}
