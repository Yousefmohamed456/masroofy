import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masroofy/common/custom_shapes/containers/circular_container.dart';
import 'package:masroofy/common/texts/section_heading.dart';
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
    final controller = Get.put(SliderController());
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard",style: Theme.of(context).textTheme.headlineLarge,)),
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
                          child: DropdownButton<String>(
                            isDense: true,
                            borderRadius: BorderRadius.circular(AppSizes.nm),
                            dropdownColor: dark
                                ? Colors.grey[900]
                                : Colors.white,
                            icon: Padding(
                              padding: const EdgeInsets.only(left: AppSizes.sm),
                              child: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: dark ? AppColors.light : AppColors.dark,
                                size: 20,
                              ),
                            ),
                            elevation: 4,
                            items: [
                              DropdownMenuItem(
                                value: 'day',
                                child: Text(
                                  'This Day',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'week',
                                child: Text(
                                  'This Week',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'year',
                                child: Text(
                                  'This Year',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ],
                            hint: Text(
                              'Time',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            onChanged: (value) {},
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
                            controller.updatePageIndicator(index),
                      ),
                      carouselController: controller.carousalController,
                    ),
                    Obx(
                      () => Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (int i = 0; i < 2; i++)
                            GestureDetector(
                              onTap: () => controller.dotNavigationClick(i),
                              child: CircularContainer(
                                width: 20,
                                height: 4,
                                margin: const EdgeInsets.only(right: 10),
                                radius: 20,
                                backGroundColor:
                                    controller.carousalCurrentIndex.value == i
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
                    TransactionItem(),
                    SizedBox(height: AppSizes.spaceBtwItems),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(AppSizes.spaceBtwItems),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.amber,
                              ),
                              child: Icon(
                                Icons.directions_car_filled,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                            SizedBox(width: AppSizes.spaceBtwItems),
                            Text(
                              'Transport\n50 EGP',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        Text(
                          '25, Mar 2026\n      Cash',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                    SizedBox(height: AppSizes.spaceBtwItems),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(AppSizes.spaceBtwItems),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.green,
                              ),
                              child: Icon(
                                Icons.account_balance,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                            SizedBox(width: AppSizes.spaceBtwItems),
                            Text(
                              'Investment\n1000 EGP',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        Text(
                          '20, Mar 2026\n      Card',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
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

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(AppSizes.spaceBtwItems),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.red,
              ),
              child: Icon(
                Icons.fastfood,
                color: Colors.white,
                size: 32,
              ),
            ),
            SizedBox(width: AppSizes.spaceBtwItems),
            Text(
              "Food\n100 EGP",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        Text(
          '27, Mar 2026\n      Cash',
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }
}
