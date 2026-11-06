import 'package:flutter/material.dart';

/// Shared spacing, sizes, radii and text styles.
abstract final class AppConstants {
  // ---------------------------------------------------------------------------
  // SPACING
  // ---------------------------------------------------------------------------
  static const double spacing2XS = 2.0;
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 12.0;
  static const double spacingL = 16.0;
  static const double spacingXL = 20.0;
  static const double spacing2XL = 24.0;
  static const double spacing3XL = 32.0;
  static const double spacing4XL = 40.0;
  static const double spacing5XL = 48.0;

  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: spacing2XL,
  );

  // ---------------------------------------------------------------------------
  // SIZES
  // ---------------------------------------------------------------------------
  static const double buttonHeight = 54.0;
  static const double buttonHeightSmall = 42.0;
  static const double iconSizeSmall = 16.0;
  static const double iconSizeMedium = 20.0;
  static const double iconSizeLarge = 28.0;

  // ---------------------------------------------------------------------------
  // RADII
  // ---------------------------------------------------------------------------
  static const double radiusS = 10.0;
  static const double radiusM = 14.0;
  static const double radiusL = 20.0;
  static const double radiusXL = 24.0;
  static const double radiusFull = 999.0;

  static const BorderRadius bottomSheetRadius = BorderRadius.vertical(
    top: Radius.circular(radiusXL),
  );

  // ---------------------------------------------------------------------------
  // TYPOGRAPHY (Poppins: Regular + Bold)
  // ---------------------------------------------------------------------------
  static const String fontFamily = 'Poppins';

  static const TextStyle display = TextStyle(
    fontFamily: fontFamily,
    fontSize: 30,
    fontWeight: FontWeight.bold,
    height: 1.2,
    letterSpacing: -0.5,
  );

  static const TextStyle title = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.3,
  );

  static const TextStyle heading = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    height: 1.5,
  );

  static const TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    height: 1.45,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
  );

  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.2,
  );

  static const TextStyle label = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
  );
}
