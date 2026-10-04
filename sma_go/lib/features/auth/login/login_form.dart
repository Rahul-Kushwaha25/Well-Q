import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_backdrop_theme.dart';
import '../../../core/theme/app_sizes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/validators.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_text_field.dart';
import 'login_controller.dart';

/// Title, fields, forgot-password link and submit button.
class LoginForm extends StatelessWidget {
  const LoginForm({super.key, required this.controller});

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onWave = AppBackdropTheme.of(context).onWave;

    return Form(
      key: controller.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(
            header: true,
            child: Text(
              AppStrings.loginTitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(color: onWave),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppTextField(
            controller: controller.mobileController,
            focusNode: controller.mobileFocus,
            hint: AppStrings.mobileHint,
            prefixIcon: Icons.smartphone_rounded,
            prefixLabel: AppStrings.countryCode,
            validator: AppValidators.mobileLoginId,
            errorTextColor: onWave,
            onSubmitted: (_) => controller.passwordFocus.requestFocus(),
            config: AppTextFieldConfig(
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              inputFormatters: AppInputFormatters.mobileLoginId,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: controller.passwordController,
            focusNode: controller.passwordFocus,
            hint: AppStrings.passwordHint,
            prefixIcon: Icons.lock_outline_rounded,
            validator: AppValidators.requiredPassword,
            errorTextColor: onWave,
            onSubmitted: (_) => controller.submit(),
            config: const AppTextFieldConfig(
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              isPassword: true,
            ),
          ),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: TextButton(
              onPressed: controller.onForgotPasswordTapped,
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
              child: const Text(AppStrings.forgotPassword),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Obx(
            () => AppButton(
              label: AppStrings.loginButton,
              variant: AppButtonVariant.secondary,
              icon: Icons.chevron_right_rounded,
              iconAtEnd: true,
              isLoading: controller.isLoading.value,
              onPressed: controller.submit,
            ),
          ),
        ],
      ),
    );
  }
}
