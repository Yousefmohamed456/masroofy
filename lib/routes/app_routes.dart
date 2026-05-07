import 'package:get/get.dart';
import 'package:masroofy/features/budget/screens/add/new_expense_screen.dart';
import 'package:masroofy/features/security/screens/pin_screen.dart';


class AppRoutes {
  static const String pin = '/pin';
  static const String newExpense = '/new-expense';

  static final List<GetPage> pages = [
    GetPage(
      name: pin,
      page: () => const PinScreen(),
    ),

    GetPage(
      name: newExpense,
      page: () => const NewExpenseScreen(),
    ),
  ];
}