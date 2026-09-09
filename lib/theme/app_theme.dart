import 'package:flutter/material.dart';

class AppColors {
  static const bg = Color(0xFFF6F3FF);
  static const surface = Color(0xFFFFFFFF);
  static const ink = Color(0xFF1F2937);
  static const inkSoft = Color(0xFF6B7280);
  static const primary = Color(0xFF6D5AE6);
  static const primaryDark = Color(0xFF4C3FC0);
  static const success = Color(0xFF22C55E);
  static const successBg = Color(0xFFDCFCE7);
  static const goodBg = Color(0xFFDBEAFE);
  static const warnBg = Color(0xFFFEF3C7);
  static const dangerBg = Color(0xFFFEE2E2);
  static const gold = Color(0xFFF59E0B);
}

ThemeData buildAppTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.bg,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
    fontFamily: "Roboto",
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
  );
}

BoxDecoration cardDecoration({Color? borderTop}) => BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(18),
      border: borderTop != null ? Border(top: BorderSide(color: borderTop, width: 5)) : null,
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, 8)),
      ],
    );

Color feedbackColor(String verdict) {
  switch (verdict) {
    case "excellent":
      return AppColors.successBg;
    case "good":
      return AppColors.goodBg;
    case "okay":
      return AppColors.warnBg;
    default:
      return AppColors.dangerBg;
  }
}
