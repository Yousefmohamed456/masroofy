import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masroofy/features/budget/models/budget_cycle_model.dart';
import 'package:masroofy/features/budget/repositories/budget_cycle_repository.dart';
import 'package:masroofy/navigation_menu.dart';
import 'package:masroofy/utils/popups/loaders.dart';

class BudgetCycleController extends GetxController {
  static BudgetCycleController get instance => Get.find();

  final amountController = TextEditingController();
  final Rx<DateTime?> startDate = Rx<DateTime?>(null);
  final Rx<DateTime?> endDate = Rx<DateTime?>(null);
  final Rx<BudgetCycleModel> activeCycle = BudgetCycleModel.empty().obs;
  final RxString selectedTimeFrame = 'day'.obs;
  GlobalKey<FormState> amountFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    getActiveCycle();
    super.onInit();
  }

  final BudgetCycleRepository _budgetCycleRepository =
      BudgetCycleRepository.instance;

  Future<void> pickStartDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: startDate.value ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      startDate.value = pickedDate;
    }
  }

  Future<void> pickEndDate(BuildContext context) async {
    final initial = startDate.value ?? DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: initial,
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      endDate.value = pickedDate;
    }
  }

  Future<void> addCycle() async {
    try {
      if (!amountFormKey.currentState!.validate()) {
        return;
      }
      if (startDate.value == null) {
        Loaders.errorSnackBar(
          title: 'Date Error',
          message: 'Start date is required',
        );
        return;
      }
      if (endDate.value == null) {
        Loaders.errorSnackBar(
          title: 'Date Error',
          message: 'End date is required',
        );
        return;
      }
      await _budgetCycleRepository.saveCycle(
        BudgetCycleModel(
          totalAllowance: double.parse(amountController.text.trim()),
          startDate: startDate.value!,
          endDate: endDate.value!,
        ),
      );
      Loaders.successSnackBar(
        title: 'Saved Successfully',
        message: 'Cycle is now live',
      );
      NavigationController.instance.selectedIndex.value = 0;
    } catch (e) {
      Loaders.errorSnackBar(title: 'Something went wrong', message: e);
    }
  }

  Future<void> getActiveCycle() async {
    try {
      final activeCycle = await _budgetCycleRepository.getActiveCycle();
      this.activeCycle.value = activeCycle ?? BudgetCycleModel.empty();
    } catch (e) {
      Loaders.errorSnackBar(title: 'Something went wrong', message: e);
    }
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  void updateTimeframe(String? newValue) {
    if (newValue != null) {
      selectedTimeFrame.value = newValue;
    }
  }

  String get titleLimit {
    switch (selectedTimeFrame.value) {
      case 'week':
        return "Week's Limit";
      case 'month':
        return "Month's Limit";
      case 'day':
      default:
        return "Today's Limit";
    }
  }

  double get amountLimit {
    switch (selectedTimeFrame.value) {
      case 'week':
        return activeCycle.value.weeklyLimit;
      case 'month':
        return activeCycle.value.monthlyLimit;
      case 'day':
      default:
        return activeCycle.value.dailyLimit;
    }
  }
}
