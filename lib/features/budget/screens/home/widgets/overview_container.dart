import 'package:flutter/material.dart';
import 'dart:math';
import 'package:masroofy/common/texts/currency_text.dart';
import 'package:masroofy/utils/constants/colors.dart';
import 'package:masroofy/utils/constants/sizes.dart';
import 'package:masroofy/utils/helpers/helper_functions.dart';

class OverviewContainer extends StatelessWidget {
  final double fillPercentage;

  const OverviewContainer({super.key, required this.fillPercentage});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    final double strokeWidth = 20.0;
    return CustomPaint(
      painter: CircularProgressPainter(
        percentage: fillPercentage.clamp(0, 1.0),
        progressColor: Colors.green.shade700,
        fillColor: AppColors.red.withAlpha(128),
        strokeWidth: strokeWidth,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: dark ? AppColors.dark : AppColors.dark,
          ),
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(strokeWidth - 2),
        child: Container(
          width: 200,
          height: 200,
          padding: EdgeInsets.all(AppSizes.xL),
          decoration: BoxDecoration(
            color: dark ? AppColors.darkContainer : AppColors.lightContainer,
            shape: BoxShape.circle,
            border: Border.all(
              width: 2,
              color: dark ? AppColors.dark : AppColors.dark,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Today's Limit",
                style: Theme.of(context).textTheme.headlineSmall,
                maxLines: 1,
              ),
              CurrencyText(price: '1200 ', color: AppColors.red, isLarge: true),
            ],
          ),
        ),
      ),
    );
  }
}

/// Custom Painting class to use the circle as a visual indicator for the spend amount
class CircularProgressPainter extends CustomPainter {
  final double percentage;
  final Color progressColor;
  final Color fillColor;
  final double strokeWidth;

  CircularProgressPainter({
    required this.percentage,
    required this.progressColor,
    required this.fillColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = (size.width - strokeWidth) / 2;

    // draw the background
    Paint trackPaint = Paint()
      ..color = fillColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, trackPaint);

    // draw the progress
    Paint progressPaint = Paint()
      ..color = progressColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double startAngle = -pi / 2;
    double endAngle = 2 * pi * percentage;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      endAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CircularProgressPainter oldDelegate) {
    return oldDelegate.percentage != percentage ||
        oldDelegate.progressColor != progressColor ||
        oldDelegate.fillColor != fillColor;
  }
}
