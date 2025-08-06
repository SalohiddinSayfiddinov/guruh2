import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_fonts.dart';

class AppTextStyles {
  AppTextStyles._();
  static const TextStyle h1 = TextStyle(
    fontFamily: AppFonts.figtree,
    fontSize: 32,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );
  static const TextStyle h2 = TextStyle(
    fontFamily: AppFonts.figtree,
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );
  static const TextStyle h3 = TextStyle(
    fontFamily: AppFonts.figtree,
    fontSize: 16,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );

  static const TextStyle greyLabel = TextStyle(
    fontFamily: AppFonts.figtree,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.darkText,
  );
  static const TextStyle whiteLabel = TextStyle(
    fontFamily: AppFonts.figtree,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );
  static const TextStyle minimal = TextStyle(
    fontFamily: AppFonts.figtree,
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: AppColors.darkText,
  );
}
