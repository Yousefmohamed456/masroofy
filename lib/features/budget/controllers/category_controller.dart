import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:masroofy/features/budget/repositories/category_repository.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();
  final Rx<IconData> selectedIcon = Icons.category.obs;
  final CategoryRepository _categoryRepository = CategoryRepository.instance;

  Future<void> saveCategory() async {

  }
}
