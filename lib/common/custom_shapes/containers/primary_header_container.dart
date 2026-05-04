import 'package:flutter/material.dart';

import 'circular_container.dart';
import '../curved_edges/curved_edges_widget.dart';
import '../../../../utils/constants/colors.dart';

class PrimaryHeaderContainer extends StatelessWidget {
  const PrimaryHeaderContainer({super.key, required this.child});

  final Widget child;

  // final double? height;

  @override
  Widget build(BuildContext context) {
    return CurvedEdgesWidget(
      child: Container(
        color: AppColors.primaryColor,
        padding: const EdgeInsetsGeometry.all(0),
        child: Stack(
          children: [
            Positioned(
              top: -150,
              right: -250,
              child: CircularContainer(
                width: 400,
                height: 400,
                radius: 400,
                backGroundColor: AppColors.white.withAlpha(26),
              ),
            ),
            Positioned(
              top: 100,
              right: -300,
              child: CircularContainer(
                width: 400,
                height: 400,
                radius: 400,
                backGroundColor: AppColors.white.withAlpha(26),
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
