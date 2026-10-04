import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../core/di/controller_scope.dart';
import '../../core/services/navigation_service.dart';
import '../auth/data/school_info.dart';
import 'splash_controller.dart';
import 'splash_screen.dart';

/// Route entry: creates the controller, then shows the screen.
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ControllerScope<SplashController>(
      create: () => SplashController(
        // Replace with the school the user selected / that was saved.
        school: SchoolInfo.splashDemo,
        navigation: Get.find<NavigationService>(),
      ),
      child: const SplashScreen(),
    );
  }
}
