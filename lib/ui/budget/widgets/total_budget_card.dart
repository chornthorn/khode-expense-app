import 'package:flutter/material.dart';

import '../../core/themes/app_colors.dart';
import 'stat_card.dart';

class TotalBudgetCard extends StatelessWidget {
  final int totalBudget;
  final int totalSpent;

  const TotalBudgetCard({
    super.key,
    required this.totalBudget,
    required this.totalSpent,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = totalSpent / totalBudget;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Monthly Progress',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getColorForPercentage(
                        percentage,
                      ).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: _getColorForPercentage(percentage),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      '${(percentage * 100).toInt()}% used',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: _getColorForPercentage(percentage),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              LinearProgressIndicator(
                value: percentage,
                backgroundColor: AppColors.divider,
                valueColor: AlwaysStoppedAnimation<Color>(
                  _getColorForPercentage(percentage),
                ),
                minHeight: 10,
                borderRadius: BorderRadius.circular(5),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StatCard(
                    title: 'Spent',
                    amount: '\$${totalSpent.toStringAsFixed(0)}',
                    icon: Icons.payments_outlined,
                    color: Colors.redAccent,
                  ),
                  StatCard(
                    title: 'Available',
                    amount:
                        '\$${(totalBudget - totalSpent).toStringAsFixed(0)}',
                    icon: Icons.account_balance_wallet_outlined,
                    color: Colors.green,
                  ),
                  StatCard(
                    title: 'Total',
                    amount: '\$${totalBudget.toStringAsFixed(0)}',
                    icon: Icons.assessment_outlined,
                    color: AppColors.cyclamen,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getColorForPercentage(double percentage) {
    if (percentage >= 1.0) {
      return Colors.redAccent;
    } else if (percentage >= 0.9) {
      return Colors.orange;
    } else if (percentage >= 0.75) {
      return Colors.amber;
    } else {
      return AppColors.cyclamen;
    }
  }
}
