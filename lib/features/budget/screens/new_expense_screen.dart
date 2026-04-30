import 'package:flutter/material.dart';
import 'package:masroofy/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:masroofy/common/animations/controllers/new_expense_screen_controller.dart';

class NewExpenseScreen extends StatelessWidget {
  const NewExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NewExpenseController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        leading: const BackButton(color: Colors.black87),
        title: const Text(
          "New Expense",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppSizes.lg),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Amount",
                      style: TextStyle(color: Colors.black54, fontSize: 13),
                    ),

                    const SizedBox(height: AppSizes.spaceBtwItems),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: controller.clearAmount,
                          child: const Icon(Icons.close, color: Colors.red),
                        ),

                        Obx(() => Text(
                          "${controller.amount.value} EGP",
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        )),

                        GestureDetector(
                          onTap: controller.saveExpense,
                          child: const Icon(Icons.check, color: Colors.green),
                        ),
                      ],
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppSizes.lg),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Select Category",
                      style: TextStyle(color: Colors.black54, fontSize: 13),
                    ),

                    const SizedBox(height: AppSizes.spaceBtwItems),

                    Obx(() => Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: controller.categories
                          .map((cat) => _buildCategory(cat, controller))
                          .toList(),
                    )),

                    const SizedBox(height: AppSizes.spaceBtwSections),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _showAddCategoryDialog(context, controller),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black87,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
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

  void _showAddCategoryDialog(BuildContext context, NewExpenseController controller) {
    final TextEditingController textController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text("Add Category"),
        content: TextField(
          controller: textController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Category name",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Cancel", style: TextStyle(color: Colors.black54)),
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