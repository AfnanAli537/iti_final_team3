import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_team3/bloc/like_bloc/like_bloc.dart';
import 'package:iti_final_team3/bloc/like_bloc/like_event.dart';
import 'package:iti_final_team3/bloc/like_bloc/like_state.dart';

class LikeButton extends StatelessWidget {
  final bool initialIsLiked;
  final Function(bool) onChanged;

  const LikeButton({
    super.key,
    this.initialIsLiked = false,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LikeBloc(initialIsLiked: initialIsLiked),
      child: BlocBuilder<LikeBloc, LikeState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              context.read<LikeBloc>().add(ToggleLikeEvent());
              onChanged(!state.isLiked);
            },
            child: Icon(
              state.isLiked ? Icons.favorite : Icons.favorite_border_rounded,
              color: state.isLiked
                  ? Colors.red
                  : const Color.fromARGB(255, 141, 137, 137),
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
      ),
    );
  }
}
