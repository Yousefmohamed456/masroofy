import 'package:flutter/material.dart';


import 'package:get/get.dart';
import 'package:masroofy/utils/constants/colors.dart';
import 'package:masroofy/utils/constants/sizes.dart';
import 'package:masroofy/utils/helpers/helper_functions.dart';

import 'controllers/animation_loader_controller.dart';
import 'lottie_animation.dart';

class AnimationLoaderWidget extends StatelessWidget {
  const AnimationLoaderWidget({
    super.key,
    required this.text,
    required this.animation,
    this.showAction = false,
    this.actionText,
    this.onActionPressed,
    this.animate = true,
  });

  final String text;
  final String animation;
  final bool showAction;
  final bool animate;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    // Initialize the controller right here (or globally if you prefer)
    final dotController = Get.put(BlinkingDotsController());

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieAnimation(
            width: AppHelperFunctions.screenWidth() * 0.8,
            asset: animation,
          ),
          const SizedBox(height: AppSizes.defaultSpace),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text, style: Theme.of(context).textTheme.headlineMedium),
              animate?Obx(
                () => Text(
                  ' ${dotController.dots.value}',
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.left,
                ),
              ):SizedBox(),
            ],
          ),
          const SizedBox(height: AppSizes.defaultSpace),
          showAction
              ? SizedBox(
                  width: 250,
                  child: OutlinedButton(
                    onPressed: onActionPressed,
                    child: Text(
                      actionText!,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.apply(color: AppColors.light),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
