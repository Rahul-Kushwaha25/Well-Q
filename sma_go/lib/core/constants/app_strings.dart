/// All user-facing text. Move to intl/ARB later without touching widgets.
abstract final class AppStrings {
  static const String appName = 'School App';

  // Auth
  static const String loginTitle = 'Login';
  static const String loginButton = 'Login';
  static const String forgotPassword = 'Forgot Password?';
  static const String changeSchool = 'Change School';
  static const String needHelp = 'Need Help?';
  static const String mobileHint = 'Mobile number';
  static const String passwordHint = 'Password';
  static const String countryCode = '+91';
  static const String loginSuccess = 'Logged in successfully';

  // Validation
  static const String mobileRequired = 'Enter your mobile number';
  static const String mobileInvalid = 'Enter a valid 10-digit mobile number';
  static const String passwordRequired = 'Enter your password';

  // Generic and accessibility
  static const String genericError = 'Something went wrong. Please try again.';
  static const String showPassword = 'Show password';
  static const String hidePassword = 'Hide password';
  static const String back = 'Back';
  static const String loading = 'Loading';
  static const String schoolLogo = 'School logo';

  // OTP
  static const String otpTitle = 'Verify OTP';
  static const String otpVerify = 'Verify';
  static const String otpResend = 'Resend OTP';
  static const String otpResent = 'A new OTP has been sent';
  static const String otpIncomplete = 'Enter the complete OTP';
  static const String otpVerified = 'OTP verified successfully';
  static const String otpFieldLabel = 'One-time password';

  static String otpSubtitle(int length, String mobile) =>
      'Enter the $length-digit code sent to $countryCode $mobile';

  static String resendIn(String time) => 'Resend OTP in $time';
}
