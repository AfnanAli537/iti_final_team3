import 'package:flutter_bloc/flutter_bloc.dart';
import 'theme_event.dart';
import 'theme_state.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(themeMode: ThemeMode.light)) {
    // تحميل الـ theme عند البداية
    on<LoadThemeEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      final isDark = prefs.getBool("isDark") ?? false;
      emit(
        ThemeState(
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
        ),
      );
    });

    on<ToggleThemeEvent>((event, emit) async {
      final newTheme = state.themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool("isDark", newTheme == ThemeMode.dark);

      emit(ThemeState(themeMode: newTheme));
    });
  }
}