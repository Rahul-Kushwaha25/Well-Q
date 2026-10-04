import 'package:flutter/material.dart';

import '../../../core/theme/app_sizes.dart';
import '../../../core/theme/app_splash_colors.dart';
import 'splash_shapes.dart';

/// Blue sky with white cloud edge, spiral and paper plane (top of splash).
/// Static and isolated in its own repaint boundary: it is painted once.
class SplashSky extends StatelessWidget {
  const SplashSky({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppSplashColors.of(context);
    return RepaintBoundary(
      child: ExcludeSemantics(
        child: AspectRatio(
          aspectRatio: AppSizes.splashSkyAspect,
          child: CustomPaint(painter: _SkyPainter(colors)),
        ),
      ),
    );
  }
}

class _SkyPainter extends CustomPainter {
  const _SkyPainter(this.colors);

  final AppSplashColors colors;

  // Cloud bumps as (centre x, centre y, radius), all as fractions of width.
  static const List<(double, double, double)> _bumps = [
    (0.03, 0.17, 0.07),
    (0.15, 0.22, 0.116),
    (0.31, 0.25, 0.10),
    (0.58, 0.25, 0.12),
    (0.72, 0.27, 0.08),
    (0.96, 0.20, 0.11),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final paint = Paint()..isAntiAlias = true;

    // Sky gradient.
    final skyRect = Rect.fromLTWH(0, 0, w, w * 0.27);
    paint.shader = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [colors.skyTop, colors.skyBottom],
    ).createShader(skyRect);
    canvas.drawRect(skyRect, paint);

    // Clouds (same colour as the page background).
    paint
      ..shader = null
      ..color = colors.cloud;
    for (final (x, y, r) in _bumps) {
      canvas.drawCircle(Offset(w * x, w * y), w * r, paint);
    }
    canvas.drawRect(Rect.fromLTWH(0, w * 0.25, w, w * 0.05), paint);

    // Spiral on the left cloud.
    drawSpiral(canvas, Offset(w * 0.097, w * 0.218), w * 0.025, colors.swirl);

    // Paper plane with a trail on the right.
    final plane = Path()
      ..moveTo(w * 0.925, w * 0.345)
      ..lineTo(w * 0.972, w * 0.362)
      ..lineTo(w * 0.936, w * 0.372)
      ..close();
    canvas.drawPath(plane, paint..color = colors.plane);
    final trail = Path()
      ..moveTo(w * 0.936, w * 0.372)
      ..quadraticBezierTo(w * 0.96, w * 0.40, w, w * 0.385);
    canvas.drawPath(
      trail,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.002
        ..isAntiAlias = true
        ..color = colors.planeTrail,
    );
  }

  @override
  bool shouldRepaint(_SkyPainter oldDelegate) => oldDelegate.colors != colors;
}
