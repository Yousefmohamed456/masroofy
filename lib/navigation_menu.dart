import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:masroofy/features/budget/screens/add/add_tabs_screen.dart';
import 'package:masroofy/features/budget/screens/add/new_expense_screen.dart';
import 'package:masroofy/features/budget/screens/history/history_screen.dart';
import 'package:masroofy/features/budget/screens/home/dashboard_screen.dart';
import 'package:masroofy/utils/constants/colors.dart';
import 'package:masroofy/utils/helpers/helper_functions.dart';

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
          elevation: 4,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          backgroundColor: darkMode ? AppColors.dark : AppColors.white,
          indicatorColor: darkMode
              ? AppColors.white.withAlpha(26)
              : AppColors.black.withAlpha(26),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            NavigationDestination(icon: Icon(Icons.manage_accounts), label: 'Budget'),
            NavigationDestination(icon: Icon(Icons.history), label: 'History'),
            NavigationDestination(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  static NavigationController get instance => Get.find();

  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const DashboardScreen(),
    const AddTabsScreen(),
    const HistoryScreen(),
  ];
}
