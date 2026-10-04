/// Animation timing. Interval values are fractions (0..1) of the total.
abstract final class AppMotion {
  static const Duration splash = Duration(milliseconds: 2600);

  /// Hill slides up during 0 -> splashHillEnd.
  static const double splashHillEnd = 0.30;

  /// Logo and name fade in during splashLogoInStart -> splashLogoInEnd.
  static const double splashLogoInStart = 0.15;
  static const double splashLogoInEnd = 0.40;

  /// Logo zooms out and fades during splashExitStart -> 1.
  static const double splashExitStart = 0.72;

  /// End scale of the exit zoom. Below 1 shrinks the logo (zoom out);
  /// use a value above 1 (e.g. 1.6) if you prefer it to grow instead.
  static const double splashExitScale = 0.5;
}
