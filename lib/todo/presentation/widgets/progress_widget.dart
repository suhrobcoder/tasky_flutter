import 'package:flutter/material.dart';
import 'package:tasky/core/theme/app_theme.dart';

class ProgressWidget extends StatelessWidget {
  final Color color;
  final double progress;
  final Size? size;
  const ProgressWidget(
      {required this.color, required this.progress, this.size, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size?.width ?? 90,
      height: size?.height ?? 8,
      child: CustomPaint(
        painter: ProgressPainer(
          color: color,
          progress: progress,
        ),
      ),
    );
  }
}

class ProgressPainer extends CustomPainter {
  final Color color;
  final double progress;

  ProgressPainer({required this.color, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    var radius = Radius.circular(size.height / 2);
    var backgroundPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = lightGrey;
    var progressPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;
    canvas.drawRRect(
      RRect.fromLTRBR(0, 0, size.width, size.height, radius),
      backgroundPaint,
    );
    if (progress > 0) {
      canvas.drawRRect(
        RRect.fromLTRBR(0, 0, size.width * progress, size.height, radius),
        progressPaint,
      );
    }
    canvas.save();
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
