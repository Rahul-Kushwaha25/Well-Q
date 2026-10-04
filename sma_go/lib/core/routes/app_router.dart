import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/data/otp_arguments.dart';
import '../../features/auth/data/school_info.dart';
import '../../features/auth/login/login_page.dart';
import '../../features/auth/otp/otp_page.dart';
import '../../features/splash/splash_page.dart';
import 'app_routes.dart';

/// All routes live here. Add each new screen as a [GoRoute] whose builder
/// returns that screen's `*Page` (which creates its controller).
///
/// Route arguments arrive as `state.extra`; read them defensively because
/// `extra` is lost on web reloads and deep links.
abstract final class AppRouter {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.login,
        pageBuilder: (context, state) {
          final extra = state.extra;
          return _fadePage(
            state,
            LoginPage(school: extra is SchoolInfo ? extra : null),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.otp,
        builder: (context, state) {
          final extra = state.extra;
          return OtpPage(arguments: extra is OtpArguments ? extra : null);
        },
      ),
    ],
  );

  static CustomTransitionPage<void> _fadePage(
    GoRouterState state,
    Widget child,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    );
  }
}
