import 'package:flutter/material.dart';

class TransactionActionButtons extends StatelessWidget {
  final Map<String, dynamic> transaction;
  final VoidCallback onDuplicate;
  final VoidCallback onSplit;

  const TransactionActionButtons({
    super.key,
    required this.transaction,
    required this.onDuplicate,
    required this.onSplit,
  });

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction['amount'] > 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onDuplicate,
            icon: const Icon(Icons.copy),
            label: const Text('Duplicate'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onSplit,
            icon: const Icon(Icons.call_split),
            label: const Text('Split'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              backgroundColor: isIncome ? Colors.green : Colors.redAccent,
            ),
          ),
        ),
      ],
    );
  }
}
