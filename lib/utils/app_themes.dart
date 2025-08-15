import 'package:flutter/material.dart';
import 'package:iti_final_team3/utils/app_text.dart';
import 'app_colors.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mainColor),
    appBarTheme: AppBarTheme(
      color: AppColors.appbarLightColor,
      elevation: 10,
      centerTitle: true,
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(2)),
      shadowColor: AppColors.secnderyColor,
      titleTextStyle: AppTextStyles.heading, // حجم ثابت
    ),
    scaffoldBackgroundColor: AppColors.background,
    fontFamily: 'Poppins',
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.background,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      hintStyle: const TextStyle(color: Colors.grey),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    ),
    textTheme: const TextTheme(
      bodyMedium: AppTextStyles.subheading,
      titleLarge: AppTextStyles.heading,
      displayLarge: AppTextStyles.title,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: AppTextStyles.subheading,
        foregroundColor: const Color.fromARGB(255, 42, 48, 58),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.mainColor,
        foregroundColor: AppColors.darkTextLight,
        textStyle: AppTextStyles.subheading,
      ),
    ),
    brightness: Brightness.light,
    useMaterial3: true,
  );

  static final ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.mainColor,
      brightness: Brightness.dark,
    ),
    appBarTheme: AppBarTheme(
      color: AppColors.appbarDarkColor,
      elevation: 10,
      centerTitle: true,
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(2)),
      shadowColor: AppColors.secnderyColor,
      titleTextStyle: AppTextStyles.heading.copyWith(
        color: AppColors.darkText,
      ), // نفس الحجم
    ),
    scaffoldBackgroundColor: AppColors.darkBackground,
    fontFamily: 'Poppins',
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkInputFill,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      hintStyle: const TextStyle(color: Colors.grey),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    ),
    textTheme: const TextTheme(
      bodyMedium: AppTextStyles.darkSubheading,
      titleLarge: AppTextStyles.darkHeading,
      displayLarge: AppTextStyles.darkTitle,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: AppColors.darkInputFill,
        foregroundColor: AppColors.darkTextLight,
        textStyle: AppTextStyles.subheading,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.mainColor,
        foregroundColor: Colors.white,
        textStyle: AppTextStyles.subheading,
      ),
    ),
    brightness: Brightness.dark,
    useMaterial3: true,
  );
}
