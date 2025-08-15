import 'package:flutter/material.dart';

class ThemeState {
  final ThemeMode themeMode;

  ThemeState({required this.themeMode});

  // Getter لمعرفة إذا كان الوضع الحالي Dark Mode
  bool get isDarkMode => themeMode == ThemeMode.dark;
}

// import 'package:flutter/material.dart';

// class ThemeState {
//   final ThemeMode themeMode;

//   ThemeState({required this.themeMode});

//   ThemeState copyWith({ThemeMode? themeMode}) {
//     return ThemeState(
//       themeMode: themeMode ?? this.themeMode,
//     );
//   }
// }
