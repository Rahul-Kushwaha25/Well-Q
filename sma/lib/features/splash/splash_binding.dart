import 'package:get/get.dart';

import '../../core/services/navigation_service.dart';
import '../auth/data/school_info.dart';
import 'splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
      () => SplashController(
        // Replace with the school the user selected / that was saved.
        school: SchoolInfo.splashDemo,
        navigation: Get.find<NavigationService>(),
      ),
    );
  }
}
