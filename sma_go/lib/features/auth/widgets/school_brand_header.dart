import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/school_logo.dart';
import '../data/school_info.dart';

/// Logo, school name and city shown above the login form.
///
/// Usage: `SchoolBrandHeader(school: school)`
class SchoolBrandHeader extends StatelessWidget {
  const SchoolBrandHeader({super.key, required this.school});

  final SchoolInfo school;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SchoolLogo(url: school.logoUrl),
        const SizedBox(height: AppSpacing.md),
        Text(
          school.name,
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineSmall,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          school.city,
          textAlign: TextAlign.center,
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
