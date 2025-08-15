import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_team3/bloc/favourite_bloc/favourite_bloc.dart';
import 'package:iti_final_team3/bloc/favourite_bloc/favourite_event.dart';
import 'package:iti_final_team3/bloc/favourite_bloc/favourite_state.dart';
import 'package:iti_final_team3/data/repo/image_model.dart';


class LikeButton extends StatelessWidget {
  final ImageModel image;

  const LikeButton({
    super.key,
    required this.image,
  });

  void toggleLike(BuildContext context, bool isLiked) {
    if (isLiked) {
      context.read<FavouriteBloc>().add(RemoveFavourite(image.url));
    } else {
      context.read<FavouriteBloc>().add(AddFavourite(image));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteBloc, FavouriteState>(
      builder: (context, state) {
        final isLiked = state is FavouriteLoaded &&
            state.favourites.any((fav) => fav.url == image.url);

        return GestureDetector(
          onTap: () => toggleLike(context, isLiked),
          child: Icon(
            isLiked ? Icons.favorite : Icons.favorite_border_rounded,
            color:
                isLiked ? Colors.red : const Color.fromARGB(255, 141, 137, 137),
            size: 28,
            shadows: const [
              Shadow(
                offset: Offset(1, 1),
                blurRadius: 3,
                color: Colors.black54,
              )
            ],
          ),
        );
      },
    );
  }
}