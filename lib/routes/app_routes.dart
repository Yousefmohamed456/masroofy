import 'package:get/get.dart';
import 'package:masroofy/features/security/pin_screen.dart';
import 'package:masroofy/features/budget/screens/new_expense_screen.dart';


class AppRoutes {
  static const String pin = '/pin';
  static const String newExpense = '/new-expense';

  static final List<GetPage> pages = [
    GetPage(
      name: pin,
      page: () => const PinScreen(
        title: 'Enter a 4-digit PIN',
        subtitle: 'Used to unlock the app later',
      ),
    ),

    GetPage(
      name: newExpense,
      page: () => const NewExpenseScreen(),
    ),
  ];
}