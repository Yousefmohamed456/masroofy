import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:masroofy/features/budget/controllers/budget_cycle_controller.dart';
import 'package:masroofy/utils/constants/colors.dart';
import 'package:masroofy/utils/constants/sizes.dart';
import 'package:masroofy/utils/validators/validation.dart';

class SetupCycleScreen extends StatelessWidget {
  const SetupCycleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BudgetCycleController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Initialize Budget',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppSizes.spaceBtwItems),

            Form(
              key: controller.amountFormKey,
              child: TextFormField(
                controller: controller.amountController,
                validator: (value) =>
                    AppValidator.validateEmptyText('Amount', value),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '2000',
                  label: Text('Amount'),
                  suffix: Text('EGP'),
                  prefixIcon: Icon(Icons.money),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwItems),

            // Date Pickers Row
            Row(
              children: [
                Expanded(
                  child: Obx(
                    () => DatePicker(
                      label: 'Start Date',
                      pickUpMethod: () => controller.pickStartDate(context),
                      date: controller.startDate.value == null
                          ? 'dd/mm/yyyy'
                          : DateFormat(
                              'dd/MM/yyyy',
                            ).format(controller.startDate.value!),
                    ),
                  ),
                ),

                const SizedBox(width: AppSizes.spaceBtwItems),

                Expanded(
                  child: Obx(
                    () => DatePicker(
                      label: 'End Date',
                      pickUpMethod: () => controller.pickEndDate(context),
                      date: controller.endDate.value == null
                          ? 'dd/mm/yyyy'
                          : DateFormat(
                              'dd/MM/yyyy',
                            ).format(controller.endDate.value!),
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.spaceBtwSections),

            OutlinedButton(
              onPressed: () => controller.addCycle(),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.darkGrey, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Save',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DatePicker extends StatelessWidget {
  const DatePicker({
    super.key,
    required this.label,
    this.pickUpMethod,
    this.date,
    this.color = Colors.green,
  });

  final String label;
  final VoidCallback? pickUpMethod;
  final String? date;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: AppSizes.sm),
        InkWell(
          onTap: pickUpMethod,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Text(
              date ?? '',
              style: TextStyle(
                color: date == 'dd/mm/yyyy' ? color!.withAlpha(128) : color!,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
