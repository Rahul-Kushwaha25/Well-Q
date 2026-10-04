import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/services/feedback_service.dart';
import '../../../core/services/navigation_service.dart';
import '../../../core/utils/validators.dart';
import '../data/auth_repository.dart';
import '../data/otp_arguments.dart';
import '../data/school_info.dart';

/// State and actions for the OTP screen. Verifies automatically when the last
/// digit is entered; the Verify button does the same.
class OtpController extends GetxController {
  OtpController({
    required OtpArguments arguments,
    required AuthRepository authRepository,
    required NavigationService navigation,
    required FeedbackService feedback,
  })  : _args = arguments,
        _auth = authRepository,
        _navigation = navigation,
        _feedback = feedback;

  /// Assumptions: 6-digit code, 30 s before "Resend" unlocks. Adjust to the API.
  static const int otpLength = 6;
  static const int resendSeconds = 30;

  final OtpArguments _args;
  final AuthRepository _auth;
  final NavigationService _navigation;
  final FeedbackService _feedback;

  final otpController = TextEditingController();
  final otpFocus = FocusNode();

  final isVerifying = false.obs;
  final errorText = RxnString();
  final secondsLeft = 0.obs;

  Timer? _timer;
  String _lastText = '';
  bool _isResending = false;

  SchoolInfo get school => _args.school;
  String get mobile => _args.mobile;
  bool get canGoBack => _navigation.canGoBack;
  bool get canResend => secondsLeft.value == 0;

  /// mm:ss for the resend countdown.
  String get resendTimeLabel {
    final minutes = (secondsLeft.value ~/ 60).toString().padLeft(2, '0');
    final seconds = (secondsLeft.value % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void onInit() {
    super.onInit();
    otpController.addListener(_onOtpChanged);
    _startCountdown();
  }

  @override
  void onReady() {
    super.onReady();
    otpFocus.requestFocus();
  }

  void _onOtpChanged() {
    final text = otpController.text;
    // The listener also fires for cursor moves; react to text changes only.
    if (text == _lastText) return;
    _lastText = text;

    if (errorText.value != null) errorText.value = null;
    if (text.length == otpLength) submit();
  }

  void _startCountdown() {
    _timer?.cancel();
    secondsLeft.value = resendSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsLeft.value <= 1) {
        secondsLeft.value = 0;
        timer.cancel();
      } else {
        secondsLeft.value--;
      }
    });
  }

  Future<void> submit() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (isVerifying.value) return;

    final error = AppValidators.otp(otpController.text, otpLength);
    if (error != null) {
      errorText.value = error;
      return;
    }

    isVerifying.value = true;
    try {
      await _auth.verifyOtp(loginId: mobile, otp: otpController.text);
      // Role-based home navigation is added once the home screens exist.
      _feedback.showSuccess(AppStrings.otpVerified);
    } on AuthException catch (e) {
      errorText.value = e.message;
    } catch (_) {
      _feedback.showError(AppStrings.genericError);
    } finally {
      isVerifying.value = false;
    }
  }

  Future<void> resend() async {
    if (!canResend || _isResending) return;
    _isResending = true;
    try {
      await _auth.resendOtp(loginId: mobile);
      otpController.clear();
      errorText.value = null;
      _startCountdown();
      _feedback.showInfo(AppStrings.otpResent);
      otpFocus.requestFocus();
    } on AuthException catch (e) {
      _feedback.showError(e.message);
    } catch (_) {
      _feedback.showError(AppStrings.genericError);
    } finally {
      _isResending = false;
    }
  }

  void onBackTapped() => _navigation.back();

  void onChangeSchoolTapped() => _navigation.push(AppRoutes.changeSchool);

  void onHelpTapped() => _navigation.push(AppRoutes.help);

  @override
  void onClose() {
    _timer?.cancel();
    otpController
      ..removeListener(_onOtpChanged)
      ..dispose();
    otpFocus.dispose();
    super.onClose();
  }
}
