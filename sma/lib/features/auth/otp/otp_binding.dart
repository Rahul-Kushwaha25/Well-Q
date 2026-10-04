import 'package:get/get.dart';

import '../../../core/services/feedback_service.dart';
import '../../../core/services/navigation_service.dart';
import '../data/auth_repository.dart';
import '../data/otp_arguments.dart';
import '../data/school_info.dart';
import 'otp_controller.dart';

class OtpBinding extends Bindings {
  @override
  void dependencies() {
    final args = Get.arguments;
    Get.lazyPut<OtpController>(
      () => OtpController(
        arguments: args is OtpArguments
            ? args
            : const OtpArguments(school: SchoolInfo.demo, mobile: ''),
        authRepository: Get.find<AuthRepository>(),
        navigation: Get.find<NavigationService>(),
        feedback: Get.find<FeedbackService>(),
      ),
    );
  }
}
