import 'package:flutter/material.dart';

/// Every colour for ONE brightness. Re-skin a school or brand by editing
/// the two palettes in [AppColors] and nothing else.
@immutable
class AppPalette {
  const AppPalette({
    required this.brightness,
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.background,
    required this.surface,
    required this.onSurface,
    required this.onSurfaceMuted,
    required this.outline,
    required this.error,
    required this.onError,
    required this.backdropCircle,
    required this.backdropCircleHalo,
    required this.backdropWave,
    required this.backdropWaveLight,
    required this.backdropWaveAccent,
    required this.onBackdropCircle,
    required this.onBackdropWave,
  });

  final Brightness brightness;
  final Color primary;
  final Color onPrimary;
  final Color secondary;
  final Color onSecondary;
  final Color background;
  final Color surface;
  final Color onSurface;
  final Color onSurfaceMuted;
  final Color outline;
  final Color error;
  final Color onError;

  // Shapes of the shared wave background.
  final Color backdropCircle;
  final Color backdropCircleHalo;
  final Color backdropWave;
  final Color backdropWaveLight;
  final Color backdropWaveAccent;

  /// Text/icons placed on the circles (top corners).
  final Color onBackdropCircle;

  /// Text/icons placed on the big wave (lower area).
  final Color onBackdropWave;
}

/// Best-estimate values from the reference screenshot.
abstract final class AppColors {
  static const AppPalette light = AppPalette(
    brightness: Brightness.light,
    primary: Color(0xFF0070C9),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFF6CD58B),
    onSecondary: Color(0xFF06361B),
    background: Color(0xFFF8FAF9),
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF1B1F23),
    onSurfaceMuted: Color(0xFF5F6670),
    outline: Color(0xFFC3C9D0),
    error: Color(0xFFBA1A1A),
    onError: Color(0xFFFFFFFF),
    backdropCircle: Color(0xFF6CD58B),
    backdropCircleHalo: Color(0xFFE0F5E7),
    backdropWave: Color(0xFF0070C9),
    backdropWaveLight: Color(0xFFBDD9F2),
    backdropWaveAccent: Color(0xFF3B8AD4),
    onBackdropCircle: Color(0xFF06361B),
    onBackdropWave: Color(0xFFFFFFFF),
  );

  static const AppPalette dark = AppPalette(
    brightness: Brightness.dark,
    primary: Color(0xFF4DA3F5),
    onPrimary: Color(0xFF00315A),
    secondary: Color(0xFF6CD58B),
    onSecondary: Color(0xFF06361B),
    background: Color(0xFF0E1317),
    surface: Color(0xFF1A2026),
    onSurface: Color(0xFFE3E7EB),
    onSurfaceMuted: Color(0xFFA3ADB7),
    outline: Color(0xFF3A444D),
    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    backdropCircle: Color(0xFF2F7D52),
    backdropCircleHalo: Color(0xFF183526),
    backdropWave: Color(0xFF0B4F8A),
    backdropWaveLight: Color(0xFF123A63),
    backdropWaveAccent: Color(0xFF1464A8),
    onBackdropCircle: Color(0xFFFFFFFF),
    onBackdropWave: Color(0xFFFFFFFF),
  );
}
