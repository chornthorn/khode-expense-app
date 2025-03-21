import 'package:flutter/material.dart';

import '../../core/themes/app_colors.dart';

class TransactionTypeSwitch extends StatelessWidget {
  final bool isExpense;
  final ValueChanged<bool> onExpenseChanged;

  const TransactionTypeSwitch({
    super.key,
    required this.isExpense,
    required this.onExpenseChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        child: Row(
          children: [
            Expanded(
              child: _buildTransactionTypeButton(
                title: 'Expense',
                isSelected: isExpense,
                onTap: () => onExpenseChanged(true),
                icon: Icons.arrow_upward,
                color: Colors.redAccent,
              ),
            ),
            Expanded(
              child: _buildTransactionTypeButton(
                title: 'Income',
                isSelected: !isExpense,
                onTap: () => onExpenseChanged(false),
                icon: Icons.arrow_downward,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionTypeButton({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
    required IconData icon,
    required Color color,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? color : AppColors.textSecondary,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? color : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
