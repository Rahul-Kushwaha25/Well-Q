import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../core/theme/app_sizes.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_splash_colors.dart';
import '../../shared/widgets/school_logo.dart';
import 'splash_controller.dart';
import 'widgets/splash_hill.dart';
import 'widgets/splash_sky.dart';

/// Splash: static sky on top, hill rising from the bottom, school logo and
/// name in the middle that zoom out and fade on exit.
class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppSplashColors.of(context);
    final theme = Theme.of(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      // The top of the screen is always blue, so keep light status icons.
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: colors.cloud,
        body: Stack(
          fit: StackFit.expand,
          children: [
            const Align(alignment: Alignment.topCenter, child: SplashSky()),
            Align(
              alignment: const Alignment(0, AppSizes.splashContentAlignY),
              child: FadeTransition(
                opacity: controller.logoOpacity,
                child: ScaleTransition(
                  scale: controller.logoScale,
                  child: Padding(
                    padding: AppSpacing.screenPadding,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SchoolLogo(
                          url: controller.school.logoUrl,
                          size: AppSizes.splashLogo,
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Text(
                          controller.school.name,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SlideTransition(
                position: controller.hillOffset,
                child: const SplashHill(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
