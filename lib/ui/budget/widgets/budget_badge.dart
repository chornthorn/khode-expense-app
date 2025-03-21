import 'package:flutter/material.dart';

import '../../core/themes/app_colors.dart';

class BudgetBadge extends StatelessWidget {
  final double percentage;

  const BudgetBadge({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    String text;
    Color color;

    if (percentage >= 1.0) {
      text = 'Over';
      color = Colors.redAccent;
    } else if (percentage >= 0.9) {
      text = 'Almost';
      color = Colors.orange;
    } else if (percentage <= 0.25) {
      text = 'Just Started';
      color = Colors.green;
    } else {
      text = 'On Track';
      color = AppColors.cyclamen;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
