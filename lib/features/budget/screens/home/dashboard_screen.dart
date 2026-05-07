import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:masroofy/common/custom_shapes/containers/circular_container.dart';
import 'package:masroofy/common/texts/section_heading.dart';
import 'package:masroofy/common/transaction/transaction_card.dart';
import 'package:masroofy/features/budget/controllers/budget_cycle_controller.dart';
import 'package:masroofy/features/budget/controllers/slider_controller.dart';
import 'package:masroofy/features/budget/screens/home/widgets/pie_chart_container.dart';
import 'package:masroofy/features/budget/screens/home/widgets/spending_limit_container.dart';
import 'package:masroofy/utils/constants/colors.dart';
import 'package:masroofy/utils/constants/sizes.dart';
import 'package:masroofy/utils/helpers/helper_functions.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    final sController = Get.put(SliderController());
    final controller = Get.put(BudgetCycleController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashboard",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      floatingActionButton: Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: dark ? AppColors.dark : AppColors.light,
          elevation: 4,
          shape: const CircleBorder(),
          child: Icon(
            Icons.add,
            size: 32,
            color: dark ? Colors.white70 : Colors.black,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text(
                  "Welcome Back,",
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
                  borderRadius: BorderRadius.circular(AppSizes.lg),
                ),
                child: Column(
                  children: [
                    SectionHeading(
                      title: "Spending Insights",
                      sideAction: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.nm,
                          vertical: AppSizes.sm,
                        ),
                        decoration: BoxDecoration(
                          color: dark ? Colors.grey[850] : Colors.grey[100],
                          borderRadius: BorderRadius.circular(AppSizes.nm),
                          border: Border.all(
                            color: dark ? Colors.white24 : Colors.black12,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: Obx(
                            () => DropdownButton<String>(
                              isDense: true,
                              value: controller.selectedTimeFrame.value,
                              borderRadius: BorderRadius.circular(AppSizes.nm),
                              dropdownColor: dark
                                  ? Colors.grey[900]
                                  : Colors.white,
                              icon: Padding(
                                padding: const EdgeInsets.only(
                                  left: AppSizes.sm,
                                ),
                                child: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: dark
                                      ? AppColors.light
                                      : AppColors.dark,
                                  size: 20,
                                ),
                              ),
                              elevation: 4,
                              items: [
                                DropdownMenuItem(
                                  value: 'day',
                                  child: Text(
                                    'This Day',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'week',
                                  child: Text(
                                    'This Week',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'month',
                                  child: Text(
                                    'This Month',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),
                                ),
                              ],

                              onChanged: (value) =>
                                  controller.updateTimeframe(value),
                            ),
                          ),
                        ),
                      ),
                    ),
                    CarouselSlider(
                      items: [
                        Align(
                          child: SpendingLimitContainer(fillPercentage: 0.4),
                        ),
                        Align(child: PieChartContainer()),
                      ],
                      options: CarouselOptions(
                        height: 275,
                        viewportFraction: 1,
                        onPageChanged: (index, _) =>
                            sController.updatePageIndicator(index),
                      ),
                      carouselController: sController.carousalController,
                    ),
                    Obx(
                      () => Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (int i = 0; i < 2; i++)
                            GestureDetector(
                              onTap: () => sController.dotNavigationClick(i),
                              child: CircularContainer(
                                width: 20,
                                height: 4,
                                margin: const EdgeInsets.only(right: 10),
                                radius: 20,
                                backGroundColor:
                                    sController.carousalCurrentIndex.value == i
                                    ? AppColors.primaryColor
                                    : AppColors.grey,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
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
                  borderRadius: BorderRadius.circular(AppSizes.lg),
                ),
                child: Column(
                  children: [
                    SectionHeading(
                      title: "Transactions",
                      sideAction: TextButton(
                        onPressed: () {},
                        child: Text(
                          'View All',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    ),
                    for (int i = 0; i < 3; i++)
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: AppSizes.spaceBtwItems,
                        ),
                        child: TransactionCard(
                          amount: '150',
                          categoryName: 'Food',
                          paymentMethod: "Cash",
                          transactionDate: DateFormat(
                            'dd,MMM yyyy',
                          ).format(DateTime.now()),
                          icon: Icons.fastfood,
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
