import 'package:flutter/material.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_backdrop_theme.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_sizes.dart';
import '../../../core/theme/app_spacing.dart';

/// Back arrow + "Need Help?" on the left, "Change School" on the right.
/// Pass null for any callback to hide that action.
///
/// Usage:
/// `AuthTopBar(onBack: c.onBackTapped, onHelp: c.onHelpTapped, onChangeSchool: c.onChangeSchoolTapped)`
class AuthTopBar extends StatelessWidget {
  const AuthTopBar({
    super.key,
    this.onBack,
    this.onHelp,
    this.onChangeSchool,
  });

  final VoidCallback? onBack;
  final VoidCallback? onHelp;
  final VoidCallback? onChangeSchool;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onCircle = AppBackdropTheme.of(context).onCircle;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (onBack != null)
                IconButton(
                  onPressed: onBack,
                  tooltip: AppStrings.back,
                  color: onCircle,
                  icon: const Icon(Icons.arrow_back_rounded),
                ),
              if (onHelp != null) _HelpButton(onTap: onHelp!, color: onCircle),
            ],
          ),
          const Spacer(),
          if (onChangeSchool != null)
            TextButton(
              onPressed: onChangeSchool,
              style: TextButton.styleFrom(
                foregroundColor: theme.colorScheme.onSurface,
                minimumSize: const Size(
                  AppSizes.minTouchTarget,
                  AppSizes.minTouchTarget,
                ),
                textStyle: theme.textTheme.labelMedium,
              ),
              child: const Text(AppStrings.changeSchool),
            ),
        ],
      ),
    );
  }
}

class _HelpButton extends StatelessWidget {
  const _HelpButton({required this.onTap, required this.color});

  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.smAll,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: AppSizes.minTouchTarget,
          minHeight: AppSizes.minTouchTarget,
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.support_agent_rounded,
                  size: AppSizes.iconLg, color: color),
              Text(
                AppStrings.needHelp,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
