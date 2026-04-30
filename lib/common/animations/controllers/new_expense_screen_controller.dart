import 'package:get/get.dart';

class NewExpenseController extends GetxController {

  /// Amount
  RxString amount = '0'.obs;

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

  /// Add digit to amount
  void addDigit(String digit) {
    if (amount.value == '0') {
      amount.value = digit;
    } else {
      amount.value += digit;
    }
  }

  /// Remove last digit
  void removeDigit() {
    if (amount.value.length > 1) {
      amount.value = amount.value.substring(0, amount.value.length - 1);
    } else {
      amount.value = '0';
    }
  }

  /// Clear amount
  void clearAmount() {
    amount.value = '0';
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

  /// Save expense
  void saveExpense() {
    if (amount.value == '0' || selectedCategory.value.isEmpty) {
      Get.snackbar('Error', 'Please enter amount and select category');
      return;
    }

    // TODO: save to database
    print('Amount: ${amount.value}');
    print('Category: ${selectedCategory.value}');
  }
}