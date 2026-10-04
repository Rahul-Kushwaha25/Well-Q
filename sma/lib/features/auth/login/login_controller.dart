import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/services/feedback_service.dart';
import '../../../core/services/navigation_service.dart';
import '../data/auth_repository.dart';
import '../data/school_info.dart';

/// State and actions for the login screen. No UI and no direct navigation:
/// everything goes through the injected services.
class LoginController extends GetxController {
  LoginController({
    required this.school,
    required AuthRepository authRepository,
    required NavigationService navigation,
    required FeedbackService feedback,
  })  : _auth = authRepository,
        _navigation = navigation,
        _feedback = feedback;

  final SchoolInfo school;
  final AuthRepository _auth;
  final NavigationService _navigation;
  final FeedbackService _feedback;

  final formKey = GlobalKey<FormState>();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  final mobileFocus = FocusNode();
  final passwordFocus = FocusNode();

  final isLoading = false.obs;

  bool get canGoBack => _navigation.canGoBack;

  Future<void> submit() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (isLoading.value) return;
    if (!(formKey.currentState?.validate() ?? false)) return;

    isLoading.value = true;
    try {
      await _auth.login(
        loginId: mobileController.text.trim(),
        password: passwordController.text,
      );
      // Role-based home navigation is added once the home screens exist.
      _feedback.showSuccess(AppStrings.loginSuccess);
    } on AuthException catch (e) {
      _feedback.showError(e.message);
    } catch (_) {
      _feedback.showError(AppStrings.genericError);
    } finally {
      isLoading.value = false;
    }
  }

  void onBackTapped() => _navigation.back();

  void onForgotPasswordTapped() => _navigation.push(AppRoutes.forgotPassword);

  void onChangeSchoolTapped() => _navigation.push(AppRoutes.changeSchool);

  void onHelpTapped() => _navigation.push(AppRoutes.help);

  @override
  void onClose() {
    mobileController.dispose();
    passwordController.dispose();
    mobileFocus.dispose();
    passwordFocus.dispose();
    super.onClose();
  }
}
