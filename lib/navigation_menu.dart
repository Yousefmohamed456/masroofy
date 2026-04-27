import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:masroofy/features/budget/screens/home/dashboard_screen.dart';
import 'package:masroofy/utils/utils/constants/colors.dart';
import 'package:masroofy/utils/utils/helpers/helper_functions.dart';



class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = AppHelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
            () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
          controller.selectedIndex.value = index,
          backgroundColor: darkMode ? AppColors.black : AppColors.white,
          indicatorColor: darkMode
              ? AppColors.white.withAlpha(26)
              : AppColors.black.withAlpha(26),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.document_scanner_outlined), label: 'Reports'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  static NavigationController get instance => Get.find();

  final Rx<int> selectedIndex =0.obs;

  final screens = [
    const DashboardScreen()
  ];
}
