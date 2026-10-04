import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_backdrop_theme.dart';
import '../../../core/theme/app_sizes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_otp_field.dart';
import 'otp_controller.dart';

/// Title, subtitle, OTP boxes, resend action and Verify button.
class OtpForm extends StatelessWidget {
  const OtpForm({super.key, required this.controller});

  final OtpController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onWave = AppBackdropTheme.of(context).onWave;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Semantics(
          header: true,
          child: Text(
            AppStrings.otpTitle,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(color: onWave),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          AppStrings.otpSubtitle(OtpController.otpLength, controller.mobile),
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(color: onWave),
        ),
        const SizedBox(height: AppSpacing.lg),
        Obx(
          () => AppOtpField(
            controller: controller.otpController,
            focusNode: controller.otpFocus,
            length: OtpController.otpLength,
            errorText: controller.errorText.value,
            errorTextColor: onWave,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Obx(
            () => controller.canResend
                ? TextButton(
                    onPressed: controller.resend,
                    style: TextButton.styleFrom(
                      foregroundColor: onWave,
                      minimumSize: const Size(
                        AppSizes.minTouchTarget,
                        AppSizes.minTouchTarget,
                      ),
                      textStyle: theme.textTheme.labelLarge?.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: onWave,
                      ),
                    ),
                    child: const Text(AppStrings.otpResend),
                  )
                : ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: AppSizes.minTouchTarget,
                    ),
                    child: Center(
                      child: Text(
                        AppStrings.resendIn(controller.resendTimeLabel),
                        style:
                            theme.textTheme.labelMedium?.copyWith(color: onWave),
                      ),
                    ),
                  ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Obx(
          () => AppButton(
            label: AppStrings.otpVerify,
            variant: AppButtonVariant.secondary,
            icon: Icons.chevron_right_rounded,
            iconAtEnd: true,
            isLoading: controller.isVerifying.value,
            onPressed: controller.submit,
          ),
        ),
      ],
    );
  }
}
