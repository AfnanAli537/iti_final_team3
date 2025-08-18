import 'package:flutter/material.dart';

class ThemeState {
  final ThemeMode themeMode;

  ThemeState({required this.themeMode});

  bool get isDarkMode => themeMode == ThemeMode.dark;
}