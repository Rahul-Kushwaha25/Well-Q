import 'package:flutter/foundation.dart';

import 'school_info.dart';

/// Passed as route arguments when opening the OTP screen:
/// `navigation.push(AppRoutes.otp, arguments: OtpArguments(...))`
@immutable
class OtpArguments {
  const OtpArguments({required this.school, required this.mobile});

  final SchoolInfo school;

  /// The login id the OTP was sent to, exactly as entered on the login screen.
  final String mobile;
}
