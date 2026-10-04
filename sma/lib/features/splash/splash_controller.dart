import 'package:flutter/animation.dart';
import 'package:get/get.dart';

import '../../core/routes/app_routes.dart';
import '../../core/services/navigation_service.dart';
import '../../core/theme/app_motion.dart';
import '../auth/data/school_info.dart';

/// Drives the splash animation with ONE controller and three cheap
/// transform/opacity animations, then moves on to the next screen.
class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  SplashController({
    required this.school,
    required NavigationService navigation,
  }) : _navigation = navigation;

  final SchoolInfo school;
  final NavigationService _navigation;

  late final AnimationController _animation;

  /// Hill slides up from below the screen.
  late final Animation<Offset> hillOffset;

  /// Logo + name: fade in, hold, fade out.
  late final Animation<double> logoOpacity;

  /// Logo + name: stay at 1, then zoom out while exiting.
  late final Animation<double> logoScale;

  @override
  void onInit() {
    super.onInit();
    _animation = AnimationController(vsync: this, duration: AppMotion.splash);

    hillOffset = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(
      CurvedAnimation(
        parent: _animation,
        curve: const Interval(
          0,
          AppMotion.splashHillEnd,
          curve: Curves.easeOutCubic,
        ),
      ),
    );

    logoOpacity = TweenSequence<double>([
      TweenSequenceItem(
        tween: ConstantTween<double>(0),
        weight: AppMotion.splashLogoInStart,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0, end: 1)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: AppMotion.splashLogoInEnd - AppMotion.splashLogoInStart,
      ),
      TweenSequenceItem(
        tween: ConstantTween<double>(1),
        weight: AppMotion.splashExitStart - AppMotion.splashLogoInEnd,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1, end: 0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 1 - AppMotion.splashExitStart,
      ),
    ]).animate(_animation);

    logoScale = TweenSequence<double>([
      TweenSequenceItem(
        tween: ConstantTween<double>(1),
        weight: AppMotion.splashExitStart,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1, end: AppMotion.splashExitScale)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 1 - AppMotion.splashExitStart,
      ),
    ]).animate(_animation);
  }

  @override
  void onReady() {
    super.onReady();
    _run();
  }

  Future<void> _run() async {
    await _animation.forward();
    // Decide here (saved session, selected school, ...) once that logic
    // exists. For now the splash always continues to login.
    _navigation.replaceAll(AppRoutes.login);
  }

  @override
  void onClose() {
    _animation.dispose();
    super.onClose();
  }
}
