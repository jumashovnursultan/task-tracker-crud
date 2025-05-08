import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedTimerRing extends StatelessWidget {
  const AnimatedTimerRing({
    super.key,
    required this.remaining,
    required this.total,
    required this.child,
  });

  final Duration remaining;
  final Duration total;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(
        begin: 0.0,
        end: 1.0 - (remaining.inSeconds / total.inSeconds),
      ),
      duration: const Duration(milliseconds: 500),
      builder: (context, value, _) {
        return CustomPaint(
          painter: _RingPainter(progress: value),
          child: Center(child: child),
        );
      },
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;

  _RingPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 5.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - strokeWidth;

    final backgroundPaint =
        Paint()
          ..color = Colors.transparent
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth;

    final foregroundPaint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    final sweepAngle = 2 * pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      sweepAngle,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
