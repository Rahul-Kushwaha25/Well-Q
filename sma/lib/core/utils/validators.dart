import 'package:flutter/services.dart';

import '../constants/app_strings.dart';

/// Form validators. Return a message, or null when the value is valid.
abstract final class AppValidators {
  /// Assumption from the screenshot: 10-digit mobile, optionally followed by
  /// "#<n>" (the original app shows "7878787878#1"). Adjust if the API differs.
  static final RegExp _mobileLoginId = RegExp(r'^\d{10}(#\d+)?$');

  static String? mobileLoginId(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return AppStrings.mobileRequired;
    if (!_mobileLoginId.hasMatch(text)) return AppStrings.mobileInvalid;
    return null;
  }

  static String? requiredPassword(String? value) {
    if (value == null || value.isEmpty) return AppStrings.passwordRequired;
    return null;
  }

  static String? otp(String? value, int length) {
    if (value == null || value.length != length) return AppStrings.otpIncomplete;
    return null;
  }
}

abstract final class AppInputFormatters {
  static final List<TextInputFormatter> mobileLoginId = <TextInputFormatter>[
    FilteringTextInputFormatter.allow(RegExp(r'[0-9#]')),
    LengthLimitingTextInputFormatter(14),
  ];
}
