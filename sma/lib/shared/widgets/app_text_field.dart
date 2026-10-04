import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/app_sizes.dart';
import '../../core/theme/app_spacing.dart';

/// Behaviour options, grouped to keep [AppTextField] small.
@immutable
class AppTextFieldConfig {
  const AppTextFieldConfig({
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.isPassword = false,
    this.enabled = true,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  });

  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final bool isPassword;
  final bool enabled;
  final AutovalidateMode autovalidateMode;
}

/// Filled text field styled entirely by the theme. Must sit inside a [Form]
/// for [validator] to run.
///
/// Usage:
/// ```dart
/// AppTextField(
///   controller: passwordController,
///   hint: 'Password',
///   prefixIcon: Icons.lock_outline_rounded,
///   validator: AppValidators.requiredPassword,
///   config: const AppTextFieldConfig(isPassword: true),
/// )
/// ```
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.hint,
    this.prefixIcon,
    this.prefixLabel,
    this.validator,
    this.onSubmitted,
    this.errorTextColor,
    this.config = const AppTextFieldConfig(),
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? label;
  final String? hint;
  final IconData? prefixIcon;

  /// Text shown after the icon, e.g. a country code.
  final String? prefixLabel;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onSubmitted;

  /// Use when the field sits on a coloured background where the default
  /// error colour would not be readable.
  final Color? errorTextColor;
  final AppTextFieldConfig config;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscured = true;

  Widget? _buildPrefix(ThemeData theme) {
    if (widget.prefixIcon == null && widget.prefixLabel == null) return null;
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: AppSpacing.md,
        end: AppSpacing.sm,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.prefixIcon != null)
            Icon(widget.prefixIcon, size: AppSizes.iconMd),
          if (widget.prefixIcon != null && widget.prefixLabel != null)
            const SizedBox(width: AppSpacing.sm),
          if (widget.prefixLabel != null)
            Text(widget.prefixLabel!, style: theme.textTheme.bodyLarge),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final config = widget.config;

    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      enabled: config.enabled,
      keyboardType: config.keyboardType,
      textInputAction: config.textInputAction,
      inputFormatters: config.inputFormatters,
      obscureText: config.isPassword && _obscured,
      enableSuggestions: !config.isPassword,
      autocorrect: !config.isPassword,
      autovalidateMode: config.autovalidateMode,
      validator: widget.validator,
      onFieldSubmitted: widget.onSubmitted,
      style: theme.textTheme.bodyLarge,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        prefixIcon: _buildPrefix(theme),
        suffixIcon: config.isPassword
            ? IconButton(
                tooltip: _obscured
                    ? AppStrings.showPassword
                    : AppStrings.hidePassword,
                onPressed: () => setState(() => _obscured = !_obscured),
                icon: Icon(
                  _obscured
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              )
            : null,
        errorStyle: widget.errorTextColor == null
            ? null
            : theme.textTheme.labelMedium?.copyWith(
                color: widget.errorTextColor,
              ),
      ),
    );
  }
}
