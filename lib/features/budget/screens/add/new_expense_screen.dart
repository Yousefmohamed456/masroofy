import 'package:flutter/material.dart';
import 'package:masroofy/features/budget/controllers/new_expense_screen_controller.dart';
import 'package:masroofy/utils/constants/colors.dart';
import 'package:masroofy/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:masroofy/utils/helpers/helper_functions.dart';
import 'package:masroofy/utils/validators/validation.dart';

class NewExpenseScreen extends StatelessWidget {
  const NewExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NewExpenseController());
    final dark = AppHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "New Expense",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              /// Amount Display
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSizes.lg),
                decoration: BoxDecoration(
                  color: dark ? AppColors.dark : AppColors.light,
                  borderRadius: BorderRadius.circular(AppSizes.lg),
                ),
                child: Column(
                  children: [
                    Text(
                      "Amount",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),

                    const SizedBox(height: AppSizes.spaceBtwItems),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: controller.clearAmount,
                          child: const Icon(Icons.close, color: Colors.red),
                        ),

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 80),
                            child: TextFormField(
                              style: Theme.of(context).textTheme.headlineSmall,
                              textAlign: TextAlign.center,
                              focusNode: controller.focusNode,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: !dark
                                        ? AppColors.dark
                                        : AppColors.light,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: !dark
                                        ? AppColors.dark
                                        : AppColors.light,
                                  ),
                                ),
                                suffix: Text(
                                  "EGP",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineSmall,
                                ),
                              ),
                              controller: controller.amount,
                              validator: (value) =>
                                  AppValidator.validateEmptyText(
                                    'Amount',
                                    value,
                                  ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: controller.dismiss,
                          child: const Icon(Icons.check, color: Colors.green),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSizes.spaceBtwItems),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () =>
                            _showAddCategoryDialog(context, controller),
                        style: ElevatedButton.styleFrom(
                          side: BorderSide.none,
                          elevation: 4,
                          backgroundColor: AppColors.buttonPrimary,
                        ),
                        child: const Text(
                          "Log Expense",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSizes.spaceBtwSections),

              /// Categories
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSizes.lg),
                decoration: BoxDecoration(
                  color: dark ? AppColors.dark : AppColors.light,
                  borderRadius: BorderRadius.circular(AppSizes.lg),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select Category",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),

                    const SizedBox(height: AppSizes.spaceBtwItems),

                    Obx(
                      () => Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: controller.categories
                            .map((cat) => _buildCategory(cat, controller))
                            .toList(),
                      ),
                    ),

                    const SizedBox(height: AppSizes.spaceBtwSections),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () =>
                            _showAddCategoryDialog(context, controller),
                        style: ElevatedButton.styleFrom(
                          side: BorderSide.none,
                          elevation: 4,
                          backgroundColor: AppColors.buttonPrimary,
                        ),
                        child: const Text(
                          "Add Category",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategory(String name, NewExpenseController controller) {
    return Obx(() {
      final selected = controller.selectedCategory.value == name;
      return GestureDetector(
        onTap: () => controller.selectCategory(name),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.md,
            vertical: AppSizes.sm,
          ),
          decoration: BoxDecoration(
            color: selected ? Colors.black87 : Colors.white,
            borderRadius: BorderRadius.circular(AppSizes.md),
            border: Border.all(
              color: selected ? Colors.black87 : Colors.grey.shade300,
            ),
          ),
          child: Text(
            name,
            style: TextStyle(
              color: selected ? Colors.white : Colors.black87,
              fontSize: 13,
            ),
          ),
        ),
      );
    });
  }

  void _showAddCategoryDialog(
    BuildContext context,
    NewExpenseController controller,
  ) {
    final TextEditingController textController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text("Add Category"),
        content: TextField(
          controller: textController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Category name",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.black54),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              controller.addCategory(textController.text.trim());
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black87,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text("Add", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
