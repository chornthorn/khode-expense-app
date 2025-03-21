import 'package:flutter/material.dart';

class TransactionSaveButton extends StatelessWidget {
  final bool isExpense;
  final VoidCallback onPressed;

  const TransactionSaveButton({
    super.key,
    required this.isExpense,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isExpense ? Colors.redAccent : Colors.green,
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(isExpense ? Icons.arrow_upward : Icons.arrow_downward, size: 18),
          const SizedBox(width: 8),
          Text(isExpense ? 'Save Expense' : 'Save Income'),
        ],
      ),
    );
  }
}
