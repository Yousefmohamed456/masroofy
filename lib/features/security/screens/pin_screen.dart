import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masroofy/features/security/controllers/pin_controller.dart';
import 'package:masroofy/utils/constants/colors.dart';
import 'package:masroofy/utils/constants/sizes.dart';
import 'package:masroofy/utils/helpers/helper_functions.dart';

class PinScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final void Function(String pin)? onPinEntered;

  const PinScreen({
    super.key,
    this.title = 'Enter the 4-digit PIN',
    this.subtitle = 'Used to unlock the app',
    this.onPinEntered,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PinController());
    final dark = AppHelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? AppColors.dark : AppColors.light,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.defaultSpace),
            child: Column(
              children: [
                Obx(
                  () => Text(
                    controller.isLoading.value
                        ? "Verifying ${controller.dots.value}"
                        : (controller.isSetup.value
                              ? 'Create a 4 digit PIN'
                              : title),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                const SizedBox(height: AppSizes.spaceBtwItems / 2),
                Obx(() {
                  if (!controller.isLoading.value) {
                    return Text(
                      controller.isSetup.value
                          ? subtitle
                          : 'Verify your identity',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    );
                  }
                  return SizedBox();
                }),
                const SizedBox(height: AppSizes.spaceBtwSections),

                Obx(() => _PinDisplay(pin: controller.pin.value)),

                const SizedBox(height: 36),

                _Keypad(
                  onKeyPressed: controller.onKeyPressed,
                  onDelete: controller.onRemove,
                ),

                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: Obx(
                    () => ElevatedButton(
                      onPressed:
                          (controller.pin.value.length == 4 &&
                              !controller.isLoading.value)
                          ? () {
                              controller.startLoading();
                              onPinEntered?.call(controller.pin.value);
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4CAF50),
                        disabledBackgroundColor: const Color(0xFFB0BEC5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 0,
                      ),
                      child: controller.isLoading.value
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'UNLOCK',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.5,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PinDisplay extends StatelessWidget {
  final String pin;

  const _PinDisplay({required this.pin});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      decoration: BoxDecoration(
        color: dark ? AppColors.darkContainer : AppColors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(4, (index) {
          final filled = index < pin.length;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              filled ? pin[index] : '–',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          );
        }),
      ),
    );
  }
}

class _Keypad extends StatelessWidget {
  final void Function(String) onKeyPressed;
  final VoidCallback onDelete;

  const _Keypad({required this.onKeyPressed, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    const keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['', '0', 'del'],
    ];

    return Column(
      children: keys.map((row) {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSizes.spaceBtwItems),
          child: Row(
            children: row.map((key) {
              if (key.isEmpty) return const Expanded(child: SizedBox());
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.spaceBtwItems,
                  ),
                  child: _KeyButton(
                    label: key,
                    onTap: () => key == 'del' ? onDelete() : onKeyPressed(key),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}

class _KeyButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _KeyButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    final isDelete = label == 'del';
    return InkWell(
      onTap: onTap,
      child: Container(
        height: AppSizes.buttonHeight,
        decoration: BoxDecoration(
          color: dark ? AppColors.darkContainer : AppColors.grey,
          borderRadius: BorderRadius.circular(14),
        ),
        alignment: Alignment.center,
        child: isDelete
            ? Icon(
                Icons.backspace_outlined,
                size: 22,
                color: dark ? AppColors.light : AppColors.dark,
              )
            : Text(label, style: Theme.of(context).textTheme.headlineMedium),
      ),
    );
  }
}
