import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_team3/bloc/like_bloc/like_bloc.dart';
import 'package:iti_final_team3/bloc/like_bloc/like_event.dart';
import 'package:iti_final_team3/bloc/like_bloc/like_state.dart';
import 'package:iti_final_team3/data/repo/image_model.dart';

class LikeButton extends StatelessWidget {
  final ImageModel image;

  const LikeButton({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LikeBloc, LikeState>(
      builder: (context, state) {
        bool isLiked = false;

        if (state is LikeLoaded) {
          isLiked = state.likes.any((fav) => fav.url == image.url);
        }

        return IconButton(
          icon: Icon(
            isLiked ? Icons.favorite : Icons.favorite_border,
            color: isLiked ? Colors.red : Colors.grey,
          ),
          onPressed: () {
            context.read<LikeBloc>().add(ToggleLike(image));
          },
        );
      },
    );
  }
}