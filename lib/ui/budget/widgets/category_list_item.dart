import 'package:flutter/material.dart';

import '../../core/themes/app_colors.dart';
import 'budget_badge.dart';

class CategoryListItem extends StatelessWidget {
  final Map<String, dynamic> category;
  final Function(Map<String, dynamic>) onTap;

  const CategoryListItem({
    super.key,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final budget = category['budget'] as int;
    final spent = category['spent'] as int;
    final percentage = spent / budget;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () => onTap(category),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: (category['color'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      category['icon'] as IconData,
                      color: category['color'] as Color,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category['name'] as String,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              '\$${spent.toStringAsFixed(0)}',
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color:
                                    percentage > 0.9 ? Colors.redAccent : null,
                              ),
                            ),
                            Text(
                              ' / \$${budget.toStringAsFixed(0)}',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  BudgetBadge(percentage: percentage),
                ],
              ),
              const SizedBox(height: 16),
              LinearProgressIndicator(
                value: percentage,
                backgroundColor: AppColors.divider,
                valueColor: AlwaysStoppedAnimation<Color>(
                  _getColorForPercentage(percentage),
                ),
                minHeight: 8,
                borderRadius: BorderRadius.circular(4),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${(percentage * 100).toInt()}% of budget used',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    '\$${(budget - spent).toStringAsFixed(0)} left',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: percentage > 0.9 ? Colors.redAccent : Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
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
