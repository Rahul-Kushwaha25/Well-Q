import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Colours used by the shared wave background and by text placed on it.
@immutable
class AppBackdropTheme extends ThemeExtension<AppBackdropTheme> {
  const AppBackdropTheme({
    required this.base,
    required this.circle,
    required this.circleHalo,
    required this.wave,
    required this.waveLight,
    required this.waveAccent,
    required this.onCircle,
    required this.onWave,
  });

  factory AppBackdropTheme.fromPalette(AppPalette p) => AppBackdropTheme(
        base: p.background,
        circle: p.backdropCircle,
        circleHalo: p.backdropCircleHalo,
        wave: p.backdropWave,
        waveLight: p.backdropWaveLight,
        waveAccent: p.backdropWaveAccent,
        onCircle: p.onBackdropCircle,
        onWave: p.onBackdropWave,
      );

  final Color base;
  final Color circle;
  final Color circleHalo;
  final Color wave;
  final Color waveLight;
  final Color waveAccent;
  final Color onCircle;
  final Color onWave;

  static AppBackdropTheme of(BuildContext context) =>
      Theme.of(context).extension<AppBackdropTheme>()!;

  @override
  AppBackdropTheme copyWith({
    Color? base,
    Color? circle,
    Color? circleHalo,
    Color? wave,
    Color? waveLight,
    Color? waveAccent,
    Color? onCircle,
    Color? onWave,
  }) =>
      AppBackdropTheme(
        base: base ?? this.base,
        circle: circle ?? this.circle,
        circleHalo: circleHalo ?? this.circleHalo,
        wave: wave ?? this.wave,
        waveLight: waveLight ?? this.waveLight,
        waveAccent: waveAccent ?? this.waveAccent,
        onCircle: onCircle ?? this.onCircle,
        onWave: onWave ?? this.onWave,
      );

  @override
  AppBackdropTheme lerp(ThemeExtension<AppBackdropTheme>? other, double t) {
    if (other is! AppBackdropTheme) return this;
    return AppBackdropTheme(
      base: Color.lerp(base, other.base, t)!,
      circle: Color.lerp(circle, other.circle, t)!,
      circleHalo: Color.lerp(circleHalo, other.circleHalo, t)!,
      wave: Color.lerp(wave, other.wave, t)!,
      waveLight: Color.lerp(waveLight, other.waveLight, t)!,
      waveAccent: Color.lerp(waveAccent, other.waveAccent, t)!,
      onCircle: Color.lerp(onCircle, other.onCircle, t)!,
      onWave: Color.lerp(onWave, other.onWave, t)!,
    );
  }
}
