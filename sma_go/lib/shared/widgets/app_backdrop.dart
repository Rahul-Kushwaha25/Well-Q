import 'package:flutter/material.dart';

import '../../core/theme/app_backdrop_theme.dart';
import '../../core/theme/app_sizes.dart';

/// The reusable wave background (green corner circles + blue wave).
/// Painted from theme tokens, scales to any screen, never rebuilds on
/// keyboard changes.
///
/// Usage (normally via [BackdropScaffold]):
/// ```dart
/// Stack(fit: StackFit.expand, children: [const AppBackdrop(), content])
/// ```
class AppBackdrop extends StatelessWidget {
  const AppBackdrop({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppBackdropTheme.of(context);
    return RepaintBoundary(
      child: ExcludeSemantics(
        child: SizedBox.expand(
          child: CustomPaint(painter: _BackdropPainter(theme)),
        ),
      ),
    );
  }
}

class _BackdropPainter extends CustomPainter {
  const _BackdropPainter(this.theme);

  final AppBackdropTheme theme;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final paint = Paint()..isAntiAlias = true;

    canvas.drawRect(Offset.zero & size, paint..color = theme.base);

    // Top-left circle with soft halo.
    final topLeft = Offset(w * 0.02, -w * 0.08);
    canvas.drawCircle(topLeft, w * 0.52, paint..color = theme.circleHalo);
    canvas.drawCircle(topLeft, w * 0.40, paint..color = theme.circle);

    // Top-right circle with soft halo.
    final topRight = Offset(w * 1.25, w * 0.30);
    canvas.drawCircle(topRight, w * 0.46, paint..color = theme.circleHalo);
    canvas.drawCircle(topRight, w * 0.40, paint..color = theme.circle);

    final top = AppSizes.backdropWaveTop;

    // Light wave peeking above the main wave on the right.
    final light = Path()
      ..moveTo(w * 0.30, h * top)
      ..cubicTo(w * 0.55, h * (top + 0.03), w * 0.75, h * (top - 0.01), w, h * (top + 0.015))
      ..lineTo(w, h)
      ..lineTo(w * 0.30, h)
      ..close();
    canvas.drawPath(light, paint..color = theme.waveLight);

    // Main wave.
    final wave = Path()
      ..moveTo(0, h * top)
      ..cubicTo(w * 0.20, h * (top - 0.04), w * 0.40, h * (top + 0.02), w * 0.65, h * (top + 0.03))
      ..cubicTo(w * 0.82, h * (top + 0.035), w * 0.92, h * (top + 0.025), w, h * (top + 0.05))
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();
    canvas.drawPath(wave, paint..color = theme.wave);

    // Lower-left accent band.
    final accent = Path()
      ..moveTo(0, h * 0.70)
      ..cubicTo(w * 0.08, h * 0.78, w * 0.22, h * 0.86, w * 0.62, h)
      ..lineTo(0, h)
      ..close();
    canvas.drawPath(accent, paint..color = theme.waveAccent);

    // Lower-left base-coloured swoosh that cuts the wave.
    final swoosh = Path()
      ..moveTo(0, h * 0.84)
      ..cubicTo(w * 0.18, h * 0.90, w * 0.38, h * 0.93, w * 0.62, h)
      ..lineTo(0, h)
      ..close();
    canvas.drawPath(swoosh, paint..color = theme.base);
  }

  @override
  bool shouldRepaint(_BackdropPainter oldDelegate) =>
      oldDelegate.theme != theme;
}
