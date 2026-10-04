import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/app_sizes.dart';

/// School logo from a URL, with a neutral icon when there is no URL or the
/// image fails to load.
///
/// Usage: `SchoolLogo(url: school.logoUrl, size: AppSizes.splashLogo)`
class SchoolLogo extends StatelessWidget {
  const SchoolLogo({super.key, required this.url, this.size = AppSizes.logo});

  final String url;
  final double size;

  @override
  Widget build(BuildContext context) {
    final fallback = Center(
      child: Icon(
        Icons.school_rounded,
        size: AppSizes.iconXl,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
    return SizedBox(
      width: size,
      height: size,
      child: url.isEmpty
          ? fallback
          : Image.network(
              url,
              fit: BoxFit.contain,
              semanticLabel: AppStrings.schoolLogo,
              errorBuilder: (_, __, ___) => fallback,
            ),
    );
  }
}
