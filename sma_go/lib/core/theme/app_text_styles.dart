import 'package:flutter/material.dart';

/// Type scale. Usage map:
/// headlineSmall 24/600  screen titles, school name
/// titleMedium   20/500  secondary titles (e.g. city)
/// bodyLarge     16/400  inputs, list text
/// labelLarge    16/600  buttons, links
/// labelMedium   14/500  small actions, captions
abstract final class AppTextStyles {
  /// Set a family here (and declare it in pubspec) to re-skin typography.
  static const String? fontFamily = null;

  static TextTheme textTheme(Color color) => TextTheme(
        headlineMedium: _s(28, FontWeight.w600, 1.25, color),
        headlineSmall: _s(24, FontWeight.w600, 1.25, color),
        titleLarge: _s(22, FontWeight.w600, 1.27, color),
        titleMedium: _s(20, FontWeight.w500, 1.3, color),
        titleSmall: _s(16, FontWeight.w600, 1.4, color),
        bodyLarge: _s(16, FontWeight.w400, 1.5, color),
        bodyMedium: _s(14, FontWeight.w400, 1.43, color),
        bodySmall: _s(12, FontWeight.w400, 1.33, color),
        labelLarge: _s(16, FontWeight.w600, 1.25, color),
        labelMedium: _s(14, FontWeight.w500, 1.3, color),
        labelSmall: _s(12, FontWeight.w500, 1.3, color),
      );

  static TextStyle _s(
    double size,
    FontWeight weight,
    double height,
    Color color,
  ) =>
      TextStyle(
        fontFamily: fontFamily,
        fontSize: size,
        fontWeight: weight,
        height: height,
        color: color,
      );
}
