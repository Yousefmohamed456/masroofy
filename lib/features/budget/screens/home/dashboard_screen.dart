import 'package:flutter/material.dart';
import 'package:masroofy/common/texts/section_heading.dart';
import 'package:masroofy/features/budget/screens/home/widgets/overview_container.dart';
import 'package:masroofy/utils/utils/constants/colors.dart';
import 'package:masroofy/utils/utils/constants/sizes.dart';
import 'package:masroofy/utils/utils/helpers/helper_functions.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(title: Text("data")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text(
                  "Welcome Back",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text(
                  "Ahmed Mohamed",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              SizedBox(height: AppSizes.spaceBtwSections),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(AppSizes.lg),
                decoration: BoxDecoration(
                  color: dark
                      ? AppColors.darkContainer
                      : AppColors.lightContainer,
                  borderRadius: BorderRadius.circular(AppSizes.lg)
                ),
                child: Column(
                  children: [
                    SectionHeading(title: "Spending Insights"),
                    SizedBox(height: AppSizes.spaceBtwItems),
                    Align(
                      alignment: AlignmentGeometry.center,
                      child: OverviewContainer(fillPercentage: 0.4),
                    ),
                    SizedBox(height: AppSizes.spaceBtwItems),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 64),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(elevation: 4),
                          child: Text('Log Expense'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
