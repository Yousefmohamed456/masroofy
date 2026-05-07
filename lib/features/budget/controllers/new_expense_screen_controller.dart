import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masroofy/utils/popups/loaders.dart';

class NewExpenseController extends GetxController {
  static NewExpenseController get instance => Get.find();

  /// Amount
  TextEditingController amount = TextEditingController();

  /// used  for the right mark button
  final FocusNode focusNode = FocusNode();

  /// Selected Category
  RxString selectedCategory = ''.obs;

  /// Categories List
  RxList<String> categories = <String>[
    'Food',
    'Transport',
    'Shopping',
    'Bills',
    'Other',
  ].obs;

  /// Clear amount
  void clearAmount() {
    amount.clear();
  }

  /// Select category
  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  /// Add new category
  void addCategory(String category) {
    if (category.isNotEmpty && !categories.contains(category)) {
      categories.add(category);
    }
  }

  void dismiss() => focusNode.unfocus();

  /// Save expense
  void saveExpense() {
    if (amount.text == '0') {
      Loaders.errorSnackBar(title: 'Error', message: 'Please Enter the amount');

      if (selectedCategory.value.isEmpty) {
        Loaders.errorSnackBar(
          title: 'Error',
          message: 'Please Select a Category',
        );
      }

      // TODO: save to database
    }
  }
}
