import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/widgets/backdrop_scaffold.dart';
import '../widgets/auth_top_bar.dart';
import '../widgets/school_brand_header.dart';
import 'otp_controller.dart';
import 'otp_form.dart';

/// Same background, top bar and school header as the login screen.
class OtpScreen extends GetView<OtpController> {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      topBar: AuthTopBar(
        onBack: controller.canGoBack ? controller.onBackTapped : null,
        onHelp: controller.onHelpTapped,
        onChangeSchool: controller.onChangeSchoolTapped,
      ),
      header: SchoolBrandHeader(school: controller.school),
      body: OtpForm(controller: controller),
    );
  }
}
