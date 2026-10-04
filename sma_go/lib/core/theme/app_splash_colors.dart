import 'package:flutter/material.dart';

/// Colours of the splash illustration (sky, clouds, hill, school, kids).
/// Edit [light] / [dark] to re-skin it.
@immutable
class AppSplashColors {
  const AppSplashColors({
    required this.skyTop,
    required this.skyBottom,
    required this.cloud,
    required this.swirl,
    required this.plane,
    required this.planeTrail,
    required this.sun,
    required this.heart,
    required this.smile,
    required this.onSmile,
    required this.hill,
    required this.bushLight,
    required this.bushDark,
    required this.leaf,
    required this.wall,
    required this.roof,
    required this.door,
    required this.window,
    required this.flag,
    required this.zigzag,
    required this.skin,
    required this.hair,
    required this.clothesA,
    required this.clothesB,
  });

  final Color skyTop;
  final Color skyBottom;

  /// Also used as the splash page background so clouds blend into it.
  final Color cloud;
  final Color swirl;
  final Color plane;
  final Color planeTrail;
  final Color sun;
  final Color heart;
  final Color smile;
  final Color onSmile;
  final Color hill;
  final Color bushLight;
  final Color bushDark;
  final Color leaf;
  final Color wall;
  final Color roof;
  final Color door;
  final Color window;
  final Color flag;
  final Color zigzag;
  final Color skin;
  final Color hair;
  final Color clothesA;
  final Color clothesB;

  static AppSplashColors of(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? dark : light;

  static const AppSplashColors light = AppSplashColors(
    skyTop: Color(0xFF2196F3),
    skyBottom: Color(0xFF0070C9),
    cloud: Color(0xFFFFFFFF),
    swirl: Color(0xFF8AB4F8),
    plane: Color(0xFF4A90E2),
    planeTrail: Color(0xFFF5C26B),
    sun: Color(0xFFFFD27F),
    heart: Color(0xFFF28B82),
    smile: Color(0xFFF6C560),
    onSmile: Color(0xFFFFFFFF),
    hill: Color(0xFF6ED48F),
    bushLight: Color(0xFF5CB87C),
    bushDark: Color(0xFF3E8F5E),
    leaf: Color(0xFF4FA36E),
    wall: Color(0xFFF2C078),
    roof: Color(0xFFB5651D),
    door: Color(0xFF9C5A22),
    window: Color(0xFF8CB8E8),
    flag: Color(0xFFE57368),
    zigzag: Color(0xFFF2D14F),
    skin: Color(0xFFF5D0B0),
    hair: Color(0xFF4A3A2E),
    clothesA: Color(0xFF3F51B5),
    clothesB: Color(0xFFE57368),
  );

  static const AppSplashColors dark = AppSplashColors(
    skyTop: Color(0xFF0B4F8A),
    skyBottom: Color(0xFF08365F),
    cloud: Color(0xFF0E1317),
    swirl: Color(0xFF4C6FA5),
    plane: Color(0xFF4A90E2),
    planeTrail: Color(0xFFB88A3A),
    sun: Color(0xFFC9A04F),
    heart: Color(0xFFC96B64),
    smile: Color(0xFFC9A04F),
    onSmile: Color(0xFF0E1317),
    hill: Color(0xFF2F7D52),
    bushLight: Color(0xFF286A45),
    bushDark: Color(0xFF1D4F33),
    leaf: Color(0xFF24603E),
    wall: Color(0xFFB8895A),
    roof: Color(0xFF7A4515),
    door: Color(0xFF6B3E18),
    window: Color(0xFF4C7BAA),
    flag: Color(0xFFB5544B),
    zigzag: Color(0xFFB89B2E),
    skin: Color(0xFFD7A98A),
    hair: Color(0xFF2B211A),
    clothesA: Color(0xFF2F3E8C),
    clothesB: Color(0xFFB5544B),
  );
}
