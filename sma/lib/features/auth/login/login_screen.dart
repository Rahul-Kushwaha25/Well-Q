import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/widgets/backdrop_scaffold.dart';
import '../widgets/auth_top_bar.dart';
import '../widgets/school_brand_header.dart';
import 'login_controller.dart';
import 'login_form.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      topBar: AuthTopBar(
        onBack: controller.canGoBack ? controller.onBackTapped : null,
        onHelp: controller.onHelpTapped,
        onChangeSchool: controller.onChangeSchoolTapped,
      ),
      header: SchoolBrandHeader(school: controller.school),
      body: LoginForm(controller: controller),
    );
  }
}
