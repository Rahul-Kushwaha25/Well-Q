import 'package:get/get.dart';

import '../../features/auth/login/login_binding.dart';
import '../../features/auth/login/login_screen.dart';
import '../../features/auth/otp/otp_binding.dart';
import '../../features/auth/otp/otp_screen.dart';
import '../../features/splash/splash_binding.dart';
import '../../features/splash/splash_screen.dart';
import 'app_routes.dart';

abstract final class AppPages {
  static const String initial = AppRoutes.splash;

  /// Register each new screen here with its binding.
  static final List<GetPage<dynamic>> pages = <GetPage<dynamic>>[
    GetPage<dynamic>(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage<dynamic>(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: AppRoutes.otp,
      page: () => const OtpScreen(),
      binding: OtpBinding(),
    ),
  ];
}
