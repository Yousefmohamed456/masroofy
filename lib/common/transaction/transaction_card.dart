import 'package:flutter/material.dart';
import 'package:masroofy/utils/constants/sizes.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    super.key,
    required this.categoryName,
    required this.amount,
    required this.paymentMethod,
    required this.transactionDate,
    this.icon,
  });

  final String categoryName;
  final String amount;
  final String paymentMethod;
  final String transactionDate;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if (icon != null)
              Container(
                padding: EdgeInsets.all(AppSizes.nm),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.nm),
                  color: Colors.red,
                ),
                child: Icon(icon, color: Colors.white, size: 32),
              ),
            SizedBox(width: AppSizes.spaceBtwItems),
            Text(
              "$categoryName\n$amount EGP",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        Text(
          '$transactionDate\n      $paymentMethod',
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }
}