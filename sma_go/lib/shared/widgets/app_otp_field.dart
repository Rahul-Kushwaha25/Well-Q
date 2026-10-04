import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_sizes.dart';
import '../../core/theme/app_spacing.dart';

/// Row of OTP digit boxes backed by ONE invisible text field, so typing,
/// backspace, paste and SMS autofill (iOS and Android) all work.
///
/// The caller owns [controller] and [focusNode] and reads the value from the
/// controller.
///
/// Usage:
/// ```dart
/// AppOtpField(
///   controller: otpController,
///   focusNode: otpFocus,
///   length: 6,
///   errorText: controller.errorText.value,
///   errorTextColor: AppBackdropTheme.of(context).onWave,
/// )
/// ```
class AppOtpField extends StatelessWidget {
  const AppOtpField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.length,
    this.errorText,
    this.errorTextColor,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final int length;
  final String? errorText;

  /// Use on coloured backgrounds where the default error colour is unreadable.
  final Color? errorTextColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasError = errorText != null;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListenableBuilder(
          listenable: Listenable.merge([controller, focusNode]),
          builder: (context, _) {
            final text = controller.text;
            final active = focusNode.hasFocus
                ? (text.length < length ? text.length : length - 1)
                : -1;
            return Semantics(
              container: true,
              label: AppStrings.otpFieldLabel,
              child: Stack(
                children: [
                  ExcludeSemantics(
                    child: Row(
                      children: [
                        for (var i = 0; i < length; i++) ...[
                          if (i > 0) const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: _OtpBox(
                              char: i < text.length ? text[i] : '',
                              isActive: i == active,
                              hasError: hasError,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Positioned.fill(
                    child: TextField(
                      controller: controller,
                      focusNode: focusNode,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(length),
                      ],
                      autofillHints: const [AutofillHints.oneTimeCode],
                      enableInteractiveSelection: false,
                      showCursor: false,
                      cursorColor: Colors.transparent,
                      style: const TextStyle(color: Colors.transparent),
                      decoration: const InputDecoration.collapsed(hintText: ''),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.xs),
            child: Text(
              errorText!,
              style: theme.textTheme.labelMedium?.copyWith(
                color: errorTextColor ?? theme.colorScheme.error,
              ),
            ),
          ),
      ],
    );
  }
}

class _OtpBox extends StatelessWidget {
  const _OtpBox({
    required this.char,
    required this.isActive,
    required this.hasError,
  });

  final String char;
  final bool isActive;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final highlighted = hasError || isActive;
    final borderColor = hasError
        ? scheme.error
        : (isActive ? scheme.secondary : scheme.outline);

    return Container(
      height: AppSizes.otpBoxHeight,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: AppRadius.smAll,
        border: Border.all(
          color: borderColor,
          width: highlighted ? AppSizes.borderWidth : AppSizes.borderThin,
        ),
      ),
      child: Text(char, style: theme.textTheme.titleLarge),
    );
  }
}
