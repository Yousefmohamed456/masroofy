import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:masroofy/common/custom_shapes/containers/rounded_container.dart';
import 'package:masroofy/common/texts/section_heading.dart';
import 'package:masroofy/common/transaction/transaction_card.dart';
import 'package:masroofy/utils/constants/colors.dart';
import 'package:masroofy/utils/constants/sizes.dart';
import 'package:masroofy/utils/helpers/helper_functions.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: RoundedContainer(
          width: double.infinity,
          height: 50,
          backgroundColor: dark ? AppColors.dark : AppColors.light,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.credit_card_outlined,
                    color: dark ? AppColors.light : AppColors.dark,
                    size: 40,
                  ),
                  SizedBox(width: AppSizes.spaceBtwItems),
                  Text(
                    'Card',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(width: AppSizes.spaceBtwItems),
                ],
              ),
              Icon(
                Icons.swap_horiz_outlined,
                color: dark ? AppColors.light : AppColors.dark,
                size: 32,
              ),
            ],
          ),
        ),
        actions: [
          RoundedContainer(
            padding: EdgeInsets.all(AppSizes.nm),
            backgroundColor: dark ? AppColors.dark : AppColors.light,
            radius: AppSizes.nm,
            child: Icon(Icons.search, color:dark ? AppColors.light : AppColors.dark,),
          ),
          SizedBox(width: AppSizes.spaceBtwItems),
          RoundedContainer(
            padding: EdgeInsets.all(AppSizes.nm),
            backgroundColor: dark ? AppColors.dark : AppColors.light,
            radius: AppSizes.nm,
            child: Icon(Icons.filter_alt_outlined,color:  dark ? AppColors.light : AppColors.dark,),
          ),
        ],
        actionsPadding: EdgeInsets.only(right: AppSizes.spaceBtwItems),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              SectionHeading(title: 'All Transactions', sideAction: SizedBox()),
              SizedBox(height: AppSizes.spaceBtwItems),
              RoundedContainer(
                padding: EdgeInsets.all(AppSizes.lg),
                backgroundColor: dark
                    ? AppColors.darkContainer
                    : AppColors.lightContainer,
                child: Column(
                  children: [
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
