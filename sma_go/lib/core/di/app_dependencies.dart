import 'package:get/get.dart';

import '../../features/auth/data/auth_repository.dart';
import '../routes/app_router.dart';
import '../services/feedback_service.dart';
import '../services/navigation_service.dart';

/// App-wide singletons, registered once before `runApp`.
abstract final class AppDependencies {
  static void init() {
    Get.put<NavigationService>(
      GoRouterNavigationService(AppRouter.router),
      permanent: true,
    );
    Get.put<FeedbackService>(
      SnackBarFeedbackService(AppRouter.rootNavigatorKey),
      permanent: true,
    );
    // Replace with the API-backed repository when the endpoints are known.
    Get.put<AuthRepository>(const FakeAuthRepository(), permanent: true);
  }
}
