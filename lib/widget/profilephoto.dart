import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final Color backgroundColor;
  final Color iconColor;
  final double size;

  const ProfileAvatar({
    super.key,
    required this.backgroundColor,
    required this.iconColor,
    this.size = 155,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.person, size: size * 0.58, color: iconColor),
    );
  }
}
