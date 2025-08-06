import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_fonts.dart';

class AppTheme {
  static ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: AppFonts.figtree,
        colorScheme: const ColorScheme.dark().copyWith(
          primary: AppColors.accent,
          surface: AppColors.background,
          error: AppColors.error,
        ),
        appBarTheme: const AppBarTheme(backgroundColor: AppColors.background),
        datePickerTheme: const DatePickerThemeData(
          backgroundColor: Colors.white,
          todayBorder: BorderSide(color: Colors.red),
          todayBackgroundColor: WidgetStatePropertyAll(Colors.red),
          todayForegroundColor: WidgetStatePropertyAll(Colors.white),
        ),
      );
  static ThemeData get light => ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.textPrimary,
        fontFamily: AppFonts.figtree,
        colorScheme: const ColorScheme.light().copyWith(
          primary: AppColors.accent,
          surface: AppColors.background,
          error: AppColors.error,
        ),
        appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
        datePickerTheme: const DatePickerThemeData(
          backgroundColor: Colors.white,
          todayBorder: BorderSide(color: Colors.red),
          todayBackgroundColor: WidgetStatePropertyAll(Colors.red),
          todayForegroundColor: WidgetStatePropertyAll(Colors.white),
        ),
      );
}
