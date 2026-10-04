import 'package:flutter/material.dart';

import 'app_backdrop_theme.dart';
import 'app_colors.dart';
import 'app_radius.dart';
import 'app_sizes.dart';
import 'app_spacing.dart';
import 'app_text_styles.dart';

abstract final class AppTheme {
  static final ThemeData light = _build(AppColors.light);
  static final ThemeData dark = _build(AppColors.dark);

  static ThemeData _build(AppPalette p) {
    final scheme = ColorScheme(
      brightness: p.brightness,
      primary: p.primary,
      onPrimary: p.onPrimary,
      secondary: p.secondary,
      onSecondary: p.onSecondary,
      error: p.error,
      onError: p.onError,
      surface: p.surface,
      onSurface: p.onSurface,
      onSurfaceVariant: p.onSurfaceMuted,
      outline: p.outline,
    );
    final textTheme = AppTextStyles.textTheme(p.onSurface);

    OutlineInputBorder border({
      Color? color,
      double width = AppSizes.borderWidth,
    }) {
      return OutlineInputBorder(
        borderRadius: AppRadius.smAll,
        borderSide: color == null
            ? BorderSide.none
            : BorderSide(color: color, width: width),
      );
    }

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: p.background,
      fontFamily: AppTextStyles.fontFamily,
      textTheme: textTheme,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: p.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        hintStyle: textTheme.bodyLarge?.copyWith(color: p.onSurfaceMuted),
        errorStyle: textTheme.bodySmall?.copyWith(color: p.error),
        errorMaxLines: 2,
        prefixIconColor: p.onSurface,
        suffixIconColor: p.onSurfaceMuted,
        border: border(),
        enabledBorder: border(color: p.outline, width: AppSizes.borderThin),
        disabledBorder: border(),
        focusedBorder: border(color: p.secondary),
        errorBorder: border(color: p.error),
        focusedErrorBorder: border(color: p.error),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
        contentTextStyle:
            textTheme.bodyMedium?.copyWith(color: scheme.onInverseSurface),
      ),
      extensions: <ThemeExtension<dynamic>>[AppBackdropTheme.fromPalette(p)],
    );
  }
}
