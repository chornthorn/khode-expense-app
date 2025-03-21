import 'package:flutter/material.dart';

import '../../core/themes/app_colors.dart';

class BudgetFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Function(bool) onSelected;

  const BudgetFilterChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: onSelected,
      backgroundColor: AppColors.inputBackground,
      selectedColor: AppColors.cyclamen.withOpacity(0.2),
      checkmarkColor: AppColors.cyclamen,
      labelStyle: TextStyle(
        color: isSelected ? AppColors.cyclamen : AppColors.textPrimary,
      ),
    );
  }
}
