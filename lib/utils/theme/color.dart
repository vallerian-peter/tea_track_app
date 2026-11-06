import 'package:flutter/material.dart';

abstract final class AppColors {
  // Brand (from the TeaTrack logo)
  static const Color forest = Color(0xFF14532D);
  static const Color forestDark = Color(0xFF0B3B1F);
  static const Color forestLight = Color(0xFF1F6B3D);
  static const Color leaf = Color(0xFF5FA032);
  static const Color gold = Color(0xFFF2A516);
  static const Color goldLight = Color(0xFFFDF1D3);

  // Status
  static const Color success = Color(0xFF15803D);
  static const Color successBg = Color(0xFFDCFCE7);
  static const Color warning = Color(0xFFD97706);
  static const Color warningBg = Color(0xFFFEF3C7);
  static const Color error = Color(0xFFDC2626);
  static const Color errorBg = Color(0xFFFEE2E2);
  static const Color info = Color(0xFF0284C7);
  static const Color infoBg = Color(0xFFE0F2FE);

  // Light neutrals
  static const Color ink = Color(0xFF17221C);
  static const Color inkLight = Color(0xFF4A5A50);
  static const Color inkMuted = Color(0xFF6B7A70);
  static const Color background = Color(0xFFFAFBF8);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceMuted = Color(0xFFF1F5F2);
  static const Color border = Color(0xFFDDE5DE);

  // Dark mode (matches the dark-mode logo palette)
  static const Color darkEmerald = Color(0xFF67D59A);
  static const Color darkLeaf = Color(0xFFB4D86C);
  static const Color darkBackground = Color(0xFF121A17);
  static const Color darkSurface = Color(0xFF1A2420);
  static const Color darkCard = Color(0xFF213029);
  static const Color darkBorder = Color(0xFF2A3832);
  static const Color darkText = Color(0xFFF1F7F3);
  static const Color darkTextMuted = Color(0xFF9FB3A6);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [forest, forestLight],
  );

  static const LinearGradient primaryGradientDark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2E8B57), Color(0xFF1F6B3D)],
  );
}
