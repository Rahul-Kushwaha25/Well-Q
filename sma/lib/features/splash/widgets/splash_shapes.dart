import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Small spiral used as decoration in the splash artwork.
void drawSpiral(Canvas canvas, Offset center, double radius, Color color) {
  const turns = 2.2;
  const steps = 48;
  final path = Path();
  for (var i = 0; i <= steps; i++) {
    final t = i / steps;
    final angle = t * turns * 2 * math.pi;
    final r = radius * t;
    final point = Offset(
      center.dx + r * math.cos(angle),
      center.dy + r * math.sin(angle),
    );
    if (i == 0) {
      path.moveTo(point.dx, point.dy);
    } else {
      path.lineTo(point.dx, point.dy);
    }
  }
  canvas.drawPath(
    path,
    Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.22
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..color = color,
  );
}

/// Short lines radiating from [center], like sun rays.
void drawRays(
  Canvas canvas,
  Offset center, {
  required double inner,
  required double outer,
  required int count,
  required double stroke,
  required Color color,
  double startAngle = 0,
}) {
  final paint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = stroke
    ..isAntiAlias = true
    ..color = color;
  for (var i = 0; i < count; i++) {
    final a = startAngle + i * 2 * math.pi / count;
    canvas.drawLine(
      center + Offset(math.cos(a) * inner, math.sin(a) * inner),
      center + Offset(math.cos(a) * outer, math.sin(a) * outer),
      paint,
    );
  }
}
