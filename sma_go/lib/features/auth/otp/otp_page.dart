import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../core/di/controller_scope.dart';
import '../../../core/services/feedback_service.dart';
import '../../../core/services/navigation_service.dart';
import '../data/auth_repository.dart';
import '../data/otp_arguments.dart';
import '../data/school_info.dart';
import 'otp_controller.dart';
import 'otp_screen.dart';

/// Route entry: creates the controller, then shows the screen.
class OtpPage extends StatelessWidget {
  const OtpPage({super.key, this.arguments});

  final OtpArguments? arguments;

  @override
  Widget build(BuildContext context) {
    return ControllerScope<OtpController>(
      create: () => OtpController(
        arguments: arguments ??
            const OtpArguments(school: SchoolInfo.demo, mobile: ''),
        authRepository: Get.find<AuthRepository>(),
        navigation: Get.find<NavigationService>(),
        feedback: Get.find<FeedbackService>(),
      ),
      child: const OtpScreen(),
    );
  }
}
