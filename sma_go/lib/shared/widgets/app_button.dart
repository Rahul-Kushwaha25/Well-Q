import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_sizes.dart';
import '../../core/theme/app_spacing.dart';

enum AppButtonVariant { primary, secondary, text, destructive }

/// Pill button with loading state and optional icon.
///
/// Usage:
/// ```dart
/// AppButton(
///   label: 'Login',
///   variant: AppButtonVariant.secondary,
///   icon: Icons.chevron_right_rounded,
///   iconAtEnd: true,
///   isLoading: controller.isLoading.value,
///   onPressed: controller.submit,
/// )
/// ```
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.icon,
    this.iconAtEnd = false,
    this.expand = true,
  });

  final String label;

  /// Null disables the button.
  final VoidCallback? onPressed;
  final AppButtonVariant variant;

  /// Shows a spinner and ignores taps while keeping the button's colours.
  final bool isLoading;
  final IconData? icon;
  final bool iconAtEnd;

  /// Full width when true, wraps its content when false.
  final bool expand;

  static void _ignoreTap() {}

  (Color, Color) _colors(ColorScheme scheme) => switch (variant) {
        AppButtonVariant.primary => (scheme.primary, scheme.onPrimary),
        AppButtonVariant.secondary => (scheme.secondary, scheme.onSecondary),
        AppButtonVariant.destructive => (scheme.error, scheme.onError),
        AppButtonVariant.text => (Colors.transparent, scheme.primary),
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final (background, foreground) = _colors(theme.colorScheme);
    final VoidCallback? handler =
        onPressed == null ? null : (isLoading ? _ignoreTap : onPressed);

    final minimumSize = Size(
      expand ? double.infinity : AppSizes.minTouchTarget,
      AppSizes.buttonHeight,
    );
    const shape = RoundedRectangleBorder(borderRadius: AppRadius.pillAll);
    final textStyle = theme.textTheme.labelLarge;
    final content = _ButtonContent(
      label: label,
      icon: icon,
      iconAtEnd: iconAtEnd,
      isLoading: isLoading,
      color: foreground,
    );

    final Widget button = variant == AppButtonVariant.text
        ? TextButton(
            onPressed: handler,
            style: TextButton.styleFrom(
              foregroundColor: foreground,
              minimumSize: minimumSize,
              shape: shape,
              textStyle: textStyle,
            ),
            child: content,
          )
        : FilledButton(
            onPressed: handler,
            style: FilledButton.styleFrom(
              backgroundColor: background,
              foregroundColor: foreground,
              minimumSize: minimumSize,
              shape: shape,
              textStyle: textStyle,
            ),
            child: content,
          );

    return Semantics(
      liveRegion: isLoading,
      label: isLoading ? AppStrings.loading : null,
      child: button,
    );
  }
}

class _ButtonContent extends StatelessWidget {
  const _ButtonContent({
    required this.label,
    required this.icon,
    required this.iconAtEnd,
    required this.isLoading,
    required this.color,
  });

  final String label;
  final IconData? icon;
  final bool iconAtEnd;
  final bool isLoading;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        width: AppSizes.iconMd,
        height: AppSizes.iconMd,
        child: CircularProgressIndicator(
          strokeWidth: AppSizes.progressStroke,
          color: color,
        ),
      );
    }

    final text = Flexible(
      child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
    );
    if (icon == null) return text;

    final iconWidget = Icon(icon, size: AppSizes.iconMd);
    const gap = SizedBox(width: AppSpacing.sm);
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: iconAtEnd ? [text, gap, iconWidget] : [iconWidget, gap, text],
    );
  }
}
