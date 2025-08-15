import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  final bool initialIsLiked;
  final Function(bool) onChanged;

  const LikeButton({
    super.key,
    this.initialIsLiked = false,
    required this.onChanged,
  });

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  late bool isLiked;

  @override
  void initState() {
    super.initState();
    isLiked = widget.initialIsLiked;
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
    widget.onChanged(isLiked);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleLike,
      child: Icon(
        isLiked ? Icons.favorite : Icons.favorite_border_rounded,
        color: isLiked ? Colors.red : const Color.fromARGB(255, 141, 137, 137),
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
  }
}
