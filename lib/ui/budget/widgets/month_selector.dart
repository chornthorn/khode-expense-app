import 'package:flutter/material.dart';

import '../../core/themes/app_colors.dart';

class MonthSelector extends StatelessWidget {
  final String month;
  final String year;
  final Color textColor;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;

  const MonthSelector({
    super.key,
    required this.month,
    required this.year,
    this.textColor = AppColors.textPrimary,
    required this.onPreviousMonth,
    required this.onNextMonth,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.chevron_left, color: textColor),
          onPressed: onPreviousMonth,
        ),
        Text(
          '$month $year',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          icon: Icon(Icons.chevron_right, color: textColor),
          onPressed: onNextMonth,
        ),
      ],
    );
  }
}
