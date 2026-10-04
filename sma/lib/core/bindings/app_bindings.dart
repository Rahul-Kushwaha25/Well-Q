import 'package:get/get.dart';

import '../../features/auth/data/auth_repository.dart';
import '../services/feedback_service.dart';
import '../services/navigation_service.dart';

/// App-wide dependencies, registered once at startup.
class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<NavigationService>(const GetNavigationService(), permanent: true);
    Get.put<FeedbackService>(const SnackBarFeedbackService(), permanent: true);
    // Replace with the API-backed repository when the endpoints are known.
    Get.put<AuthRepository>(const FakeAuthRepository(), permanent: true);
  }
}
