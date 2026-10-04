/// Fixed dimensions that are neither spacing nor radius.
abstract final class AppSizes {
  static const double minTouchTarget = 48;
  static const double buttonHeight = 56;
  static const double otpBoxHeight = 56;

  static const double iconMd = 24;
  static const double iconLg = 32;
  static const double iconXl = 64;

  static const double logo = 128;

  /// Keeps forms readable on tablets and landscape.
  static const double contentMaxWidth = 420;

  static const double borderThin = 1;
  static const double borderWidth = 2;
  static const double progressStroke = 2.5;

  /// Where the main wave starts, as a fraction of screen height. The
  /// background painter and the scaffold's header/body split both use it,
  /// so content always lines up with the artwork.
  static const double backdropWaveTop = 0.40;

  // Splash
  static const double splashLogo = 176;

  /// Vertical alignment (-1 top .. 1 bottom) of the logo + name block.
  static const double splashContentAlignY = -0.15;

  /// Width / height of the painted sky and hill artwork.
  static const double splashSkyAspect = 2.5;
  static const double splashHillAspect = 2.0;
}
