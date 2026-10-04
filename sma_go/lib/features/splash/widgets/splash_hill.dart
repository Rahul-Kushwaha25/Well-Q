import 'package:flutter/material.dart';

import '../../../core/theme/app_sizes.dart';
import '../../../core/theme/app_splash_colors.dart';
import 'splash_shapes.dart';

/// Hill with the school, bushes, sun, heart and children (bottom of splash).
///
/// Painted once inside a [RepaintBoundary], so sliding it with a
/// `SlideTransition` only moves a cached layer and costs almost nothing.
class SplashHill extends StatelessWidget {
  const SplashHill({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppSplashColors.of(context);
    return RepaintBoundary(
      child: ExcludeSemantics(
        child: AspectRatio(
          aspectRatio: AppSizes.splashHillAspect,
          child: CustomPaint(painter: _HillPainter(colors)),
        ),
      ),
    );
  }
}

class _HillPainter extends CustomPainter {
  const _HillPainter(this.colors);

  final AppSplashColors colors;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final paint = Paint()..isAntiAlias = true;

    _drawSkyDecor(canvas, w, paint);
    _drawGround(canvas, w, h, paint);
    _drawBushes(canvas, w, paint);
    _drawSchool(canvas, w, paint);
    _drawExtras(canvas, w, paint);
    _drawChildren(canvas, w, paint);
  }

  void _drawSkyDecor(Canvas canvas, double w, Paint paint) {
    // Sun.
    final sun = Offset(w * 0.322, w * 0.058);
    canvas.drawCircle(sun, w * 0.022, paint..color = colors.sun);
    drawRays(canvas, sun,
        inner: w * 0.038, outer: w * 0.06, count: 8, stroke: w * 0.006, color: colors.sun);

    // Heart with rays.
    final heart = Offset(w * 0.18, w * 0.128);
    final s = w * 0.022;
    final path = Path()
      ..moveTo(heart.dx, heart.dy + s * 0.9)
      ..cubicTo(heart.dx - s * 1.6, heart.dy - s * 0.2, heart.dx - s * 0.7,
          heart.dy - s * 1.2, heart.dx, heart.dy - s * 0.4)
      ..cubicTo(heart.dx + s * 0.7, heart.dy - s * 1.2, heart.dx + s * 1.6,
          heart.dy - s * 0.2, heart.dx, heart.dy + s * 0.9);
    canvas.drawPath(path, paint..color = colors.heart);
    drawRays(canvas, heart,
        inner: w * 0.046, outer: w * 0.066, count: 8, stroke: w * 0.004,
        color: colors.heart, startAngle: 0.2);

    // Smiling sun on the right.
    final smile = Offset(w * 0.82, w * 0.079);
    canvas.drawCircle(smile, w * 0.032, paint..color = colors.smile);
    canvas.drawArc(
      Rect.fromCircle(center: smile.translate(0, w * 0.002), radius: w * 0.017),
      0.3,
      2.5,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.006
        ..strokeCap = StrokeCap.round
        ..isAntiAlias = true
        ..color = colors.onSmile,
    );
  }

  void _drawGround(Canvas canvas, double w, double h, Paint paint) {
    final hill = Path()
      ..moveTo(0, w * 0.35)
      ..cubicTo(w * 0.12, w * 0.285, w * 0.30, w * 0.275, w * 0.50, w * 0.30)
      ..cubicTo(w * 0.70, w * 0.325, w * 0.90, w * 0.30, w, w * 0.27)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();
    canvas.drawPath(hill, paint..color = colors.hill);
  }

  void _drawBushes(Canvas canvas, double w, Paint paint) {
    final light = Path()
      ..moveTo(w * 0.58, w * 0.50)
      ..lineTo(w * 0.58, w * 0.40)
      ..cubicTo(w * 0.62, w * 0.31, w * 0.78, w * 0.30, w * 0.84, w * 0.24)
      ..cubicTo(w * 0.90, w * 0.18, w * 0.97, w * 0.20, w, w * 0.12)
      ..lineTo(w, w * 0.50)
      ..close();
    canvas.drawPath(light, paint..color = colors.bushLight);

    final dark = Path()
      ..moveTo(w * 0.76, w * 0.50)
      ..cubicTo(w * 0.80, w * 0.38, w * 0.88, w * 0.36, w * 0.92, w * 0.30)
      ..cubicTo(w * 0.96, w * 0.24, w * 0.99, w * 0.26, w, w * 0.20)
      ..lineTo(w, w * 0.50)
      ..close();
    canvas.drawPath(dark, paint..color = colors.bushDark);

    // Leaves: (x, y, width, height, rotation).
    const leaves = <(double, double, double, double, double)>[
      (0.89, 0.118, 0.045, 0.10, -0.5),
      (0.958, 0.083, 0.04, 0.12, 0.3),
      (0.985, 0.025, 0.035, 0.09, 0.1),
    ];
    paint.color = colors.leaf;
    for (final (x, y, lw, lh, angle) in leaves) {
      canvas
        ..save()
        ..translate(w * x, w * y)
        ..rotate(angle)
        ..drawOval(
          Rect.fromCenter(center: Offset.zero, width: w * lw, height: w * lh),
          paint,
        )
        ..restore();
    }
  }

  void _drawSchool(Canvas canvas, double w, Paint paint) {
    Rect r(double l, double t, double rt, double b) =>
        Rect.fromLTRB(w * l, w * t, w * rt, w * b);

    // Walls and clock tower.
    canvas.drawRect(r(0.465, 0.235, 0.675, 0.305), paint..color = colors.wall);
    canvas.drawRect(r(0.535, 0.150, 0.585, 0.215), paint..color = colors.wall);

    // Roofs.
    final roof = Path()
      ..moveTo(w * 0.445, w * 0.245)
      ..lineTo(w * 0.50, w * 0.205)
      ..lineTo(w * 0.64, w * 0.205)
      ..lineTo(w * 0.695, w * 0.245)
      ..close();
    canvas.drawPath(roof, paint..color = colors.roof);
    final towerRoof = Path()
      ..moveTo(w * 0.525, w * 0.155)
      ..lineTo(w * 0.56, w * 0.115)
      ..lineTo(w * 0.595, w * 0.155)
      ..close();
    canvas.drawPath(towerRoof, paint..color = colors.roof);

    // Flag and clock.
    canvas.drawLine(
      Offset(w * 0.56, w * 0.115),
      Offset(w * 0.56, w * 0.092),
      Paint()
        ..strokeWidth = w * 0.003
        ..color = colors.roof,
    );
    final flag = Path()
      ..moveTo(w * 0.56, w * 0.092)
      ..lineTo(w * 0.585, w * 0.099)
      ..lineTo(w * 0.56, w * 0.106)
      ..close();
    canvas.drawPath(flag, paint..color = colors.flag);
    canvas.drawCircle(
        Offset(w * 0.56, w * 0.175), w * 0.011, paint..color = colors.window);

    // Windows and door.
    paint.color = colors.window;
    for (final x in const [0.485, 0.525, 0.60, 0.64]) {
      canvas.drawRect(r(x, 0.255, x + 0.02, 0.285), paint);
    }
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        r(0.545, 0.265, 0.575, 0.305),
        topLeft: Radius.circular(w * 0.015),
        topRight: Radius.circular(w * 0.015),
      ),
      paint..color = colors.door,
    );
  }

  void _drawExtras(Canvas canvas, double w, Paint paint) {
    // Zigzag next to the school.
    final zigzag = Path()
      ..moveTo(w * 0.60, w * 0.285)
      ..lineTo(w * 0.615, w * 0.27)
      ..lineTo(w * 0.63, w * 0.285)
      ..lineTo(w * 0.645, w * 0.27);
    canvas.drawPath(
      zigzag,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.006
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..isAntiAlias = true
        ..color = colors.zigzag,
    );

    drawSpiral(canvas, Offset(w * 0.875, w * 0.28), w * 0.025, colors.swirl);
  }

  void _drawChildren(Canvas canvas, double w, Paint paint) {
    // (x, height, clothes colour). Feet rest on the hill at y = 0.355w.
    final figures = <(double, double, Color)>[
      (0.125, 0.055, colors.clothesA),
      (0.160, 0.085, colors.clothesA),
      (0.195, 0.058, colors.clothesB),
      (0.215, 0.050, colors.clothesA),
      (0.238, 0.082, colors.clothesB),
    ];
    final foot = w * 0.355;
    for (final (x, height, clothes) in figures) {
      final fh = w * height;
      final cx = w * x;
      final headR = fh * 0.14;
      final headC = Offset(cx, foot - fh + headR);
      // Legs, body, head, hair.
      canvas.drawRect(
        Rect.fromLTRB(cx - fh * 0.09, foot - fh * 0.28, cx + fh * 0.09, foot),
        paint..color = colors.hair,
      );
      canvas.drawRect(
        Rect.fromLTRB(cx - fh * 0.14, headC.dy + headR, cx + fh * 0.14, foot - fh * 0.26),
        paint..color = clothes,
      );
      canvas.drawCircle(headC, headR, paint..color = colors.skin);
      canvas.drawArc(
        Rect.fromCircle(center: headC, radius: headR),
        3.14159,
        3.14159,
        true,
        paint..color = colors.hair,
      );
    }
  }

  @override
  bool shouldRepaint(_HillPainter oldDelegate) => oldDelegate.colors != colors;
}
