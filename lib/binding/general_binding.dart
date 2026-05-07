import 'package:get/get.dart';
import 'package:masroofy/features/budget/repositories/budget_cycle_repository.dart';
import 'package:masroofy/features/budget/repositories/category_repository.dart';
import 'package:masroofy/utils/sqflite/database_helper.dart';

class GeneralBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DatabaseHelper());

    Get.put(BudgetCycleRepository());

    Get.put(CategoryRepository());
  }
}
