import 'package:flutter/material.dart';
import 'package:masroofy/features/budget/screens/add/new_expense_screen.dart';
import 'package:masroofy/features/budget/screens/add/setup_cycle_screen.dart';

class AddTabsScreen extends StatelessWidget {
  const AddTabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Manage Budget'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Add Expense',icon:Icon(Icons.attach_money),),
              Tab(text: 'Budget Cycle',icon:Icon(Icons.recycling_outlined),),
            ],
          ),
        ),
        body: const TabBarView(
          children: [NewExpenseScreen(), SetupCycleScreen()],
        ),
      ),
    );
  }
}
