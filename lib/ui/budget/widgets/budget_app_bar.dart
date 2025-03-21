import 'package:flutter/material.dart';

import '../../core/themes/app_colors.dart';
import 'month_selector.dart';

class BudgetAppBar extends StatelessWidget {
  final Map<String, dynamic> monthlyBudget;
  final VoidCallback onNavigateToPreviousMonth;
  final VoidCallback onNavigateToNextMonth;
  final VoidCallback onCalendarPressed;
  final VoidCallback onMoreOptionsPressed;

  const BudgetAppBar({
    super.key,
    required this.monthlyBudget,
    required this.onNavigateToPreviousMonth,
    required this.onNavigateToNextMonth,
    required this.onCalendarPressed,
    required this.onMoreOptionsPressed,
  });

  @override
  Widget build(BuildContext context) {
    final totalBudget = monthlyBudget['totalBudget'];
    final totalSpent = monthlyBudget['totalSpent'];
    final remaining = totalBudget - totalSpent;

    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.cyclamen, AppColors.amethyst],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 50, 16, 0),
              child: Column(
                children: [
                  MonthSelector(
                    month: monthlyBudget['month'],
                    year: monthlyBudget['year'],
                    textColor: Colors.white,
                    onPreviousMonth: onNavigateToPreviousMonth,
                    onNextMonth: onNavigateToNextMonth,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildSummaryItem(
                        context,
                        'Total Budget',
                        '\$${totalBudget.toStringAsFixed(0)}',
                        Colors.white,
                      ),
                      Container(
                        height: 40,
                        width: 1,
                        color: Colors.white.withOpacity(0.3),
                      ),
                      _buildSummaryItem(
                        context,
                        'Remaining',
                        '\$${remaining.toStringAsFixed(0)}',
                        Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        titlePadding: const EdgeInsets.all(16),
        title: const Text('Budget'),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.calendar_today_outlined),
          onPressed: onCalendarPressed,
        ),
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: onMoreOptionsPressed,
        ),
      ],
    );
  }

  Widget _buildSummaryItem(
    BuildContext context,
    String title,
    String value,
    Color textColor,
  ) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: textColor.withOpacity(0.8)),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
