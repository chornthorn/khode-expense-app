import 'package:flutter/material.dart';

import '../../core/themes/app_colors.dart';

class BudgetOverviewList extends StatelessWidget {
  final List<Map<String, dynamic>> budgets;

  const BudgetOverviewList({super.key, required this.budgets});

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsive sizing
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return Column(
      children:
          budgets.map((budget) {
            double percentage =
                (budget['spent'] as int) / (budget['total'] as int);
            return Card(
              margin: EdgeInsets.only(bottom: isSmallScreen ? 8 : 12),
              child: Padding(
                padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(isSmallScreen ? 6 : 8),
                          decoration: BoxDecoration(
                            color: (budget['color'] as Color).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            budget['icon'] as IconData,
                            color: budget['color'] as Color,
                            size: isSmallScreen ? 16 : 20,
                          ),
                        ),
                        SizedBox(width: isSmallScreen ? 8 : 12),
                        Expanded(
                          child: Text(
                            budget['category'] as String,
                            style: TextStyle(
                              fontSize: isSmallScreen ? 14 : 16,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          '\$${budget['spent']} / \$${budget['total']}',
                          style: TextStyle(fontSize: isSmallScreen ? 12 : 14),
                        ),
                      ],
                    ),
                    SizedBox(height: isSmallScreen ? 12 : 16),
                    LinearProgressIndicator(
                      value: percentage,
                      backgroundColor: AppColors.divider,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        percentage > 0.9
                            ? Colors.redAccent
                            : budget['color'] as Color,
                      ),
                      minHeight: isSmallScreen ? 6 : 8,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${(percentage * 100).toInt()}% of budget used',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 11 : 12,
                        color:
                            percentage > 0.9
                                ? Colors.redAccent
                                : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
    );
  }
}
