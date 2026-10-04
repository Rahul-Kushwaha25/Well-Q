import 'package:get/get.dart';

import '../../../core/services/feedback_service.dart';
import '../../../core/services/navigation_service.dart';
import '../data/auth_repository.dart';
import '../data/school_info.dart';
import 'login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    final args = Get.arguments;
    Get.lazyPut<LoginController>(
      () => LoginController(
        school: args is SchoolInfo ? args : SchoolInfo.demo,
        authRepository: Get.find<AuthRepository>(),
        navigation: Get.find<NavigationService>(),
        feedback: Get.find<FeedbackService>(),
      ),
    );
  }
}
