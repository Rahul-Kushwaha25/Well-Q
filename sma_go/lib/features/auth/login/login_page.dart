import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../core/di/controller_scope.dart';
import '../../../core/services/feedback_service.dart';
import '../../../core/services/navigation_service.dart';
import '../data/auth_repository.dart';
import '../data/school_info.dart';
import 'login_controller.dart';
import 'login_screen.dart';

/// Route entry: creates the controller, then shows the screen.
class LoginPage extends StatelessWidget {
  const LoginPage({super.key, this.school});

  /// Selected school; falls back to demo data until school selection exists.
  final SchoolInfo? school;

  @override
  Widget build(BuildContext context) {
    return ControllerScope<LoginController>(
      create: () => LoginController(
        school: school ?? SchoolInfo.demo,
        authRepository: Get.find<AuthRepository>(),
        navigation: Get.find<NavigationService>(),
        feedback: Get.find<FeedbackService>(),
      ),
      child: const LoginScreen(),
    );
  }
}
