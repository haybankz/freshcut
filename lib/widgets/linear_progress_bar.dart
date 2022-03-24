import 'dart:math';

import 'package:flutter/material.dart';
import 'package:freshcut/app_constants.dart';

class LinearBar extends StatelessWidget {
  final double progress;

  const LinearBar({Key? key, required this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: CustomPaint(
        child: Container(),
        painter: LinePainter(progress: progress),
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  final double progress;

  LinePainter({required this.progress});

  static double convertRadiusToSigma(double radius) {
    return radius * 0.57735 + 0.5;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double elevation = 10;
    Paint paint = Paint()
      ..color = Colors.white10
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    Offset p1 = Offset(0, size.height / 2);
    Offset p2 = Offset(size.width, size.height / 2);
    Offset pos = Offset(size.width * progress, size.height / 2);

    canvas.drawLine(p1, p2, paint);

    // don't draw progress indicator progress is zero
    if (progress > 0) {
      canvas.drawLine(p1, pos, paint..color = AppColors.sunGold);
      canvas.drawPath(
          Path()
            ..addRect(Rect.fromPoints(const Offset(-3, 3), pos))
            ..addOval(Rect.fromPoints(
                const Offset(0, 0), Offset(size.width, size.height)))
            ..fillType = PathFillType.evenOdd,
          Paint()
            ..color = AppColors.sunGold
            ..maskFilter =
                MaskFilter.blur(BlurStyle.normal, convertRadiusToSigma(6)));
    }

    // only draw white tip and blur if progress is greater than zero and less than 1
    if (progress > 0 && progress < 1) {
      // Draw Small white circle
      Rect rect = Rect.fromCircle(center: pos, radius: 3);
      canvas.drawArc(
        rect,
        0,
        pi * 2,
        false,
        paint
          ..color = Colors.white
          ..shader = const LinearGradient(
            colors: [Colors.white10, Colors.white60],
          ).createShader(rect),
      );

      // Draw Shadow
      canvas.drawShadow(
        Path()..addOval(rect.translate(0, -elevation)),
        Colors.white,
        elevation,
        false,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
