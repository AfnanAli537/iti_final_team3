import 'package:flutter/material.dart';
import 'package:iti_final_team3/utils/app_colors.dart';

class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w500,
    color: AppColors.text,
  );
  static TextStyle showTItle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.grayText,
  );
  static TextStyle showDetails = TextStyle(
    fontSize: 16,
    color: AppColors.grayText,
  );

  static const TextStyle subheading = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.textLight,
  );

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle link = TextStyle(
    fontSize: 14,
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );
  static const TextStyle darkHeading = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.darkText,
  );
  static const TextStyle darkSubheading = TextStyle(
    fontSize: 14,
    color: AppColors.darkTextLight,
  );
}
