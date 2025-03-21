import 'package:flutter/material.dart';

import '../../core/themes/app_colors.dart';

class TransactionItem extends StatelessWidget {
  final Map<String, dynamic> transaction;
  final VoidCallback onTap;

  const TransactionItem({
    super.key,
    required this.transaction,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction['amount'] > 0;
    final amountString =
        '\$${(transaction['amount'].abs()).toStringAsFixed(0)}';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: (transaction['color'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  transaction['icon'] as IconData,
                  color: transaction['color'] as Color,
                ),
              ),
              const SizedBox(width: 16),
              // Title and category
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction['title'] as String,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${transaction['category']} • ${transaction['paymentMethod']}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              // Amount
              Text(
                isIncome ? '+$amountString' : '-$amountString',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: isIncome ? Colors.green : Colors.redAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
