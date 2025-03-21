import 'package:flutter/material.dart';

import '../../../routing/app_router.dart';
import '../../core/themes/app_colors.dart';
import 'date_formatter.dart';
import 'transaction_item.dart';

class GroupedTransactionsList extends StatelessWidget {
  final List<Map<String, dynamic>> transactions;

  const GroupedTransactionsList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    // Group transactions by date
    final groupedTransactions = <String, List<Map<String, dynamic>>>{};

    for (final tx in transactions) {
      final date = tx['date'] as DateTime;
      final dateString = TransactionDateFormatter.formatDate(date);

      if (!groupedTransactions.containsKey(dateString)) {
        groupedTransactions[dateString] = [];
      }

      groupedTransactions[dateString]!.add(tx);
    }

    // Sort dates
    final sortedDates =
        groupedTransactions.keys.toList()..sort(
          (a, b) => TransactionDateFormatter.parseDate(
            b,
          ).compareTo(TransactionDateFormatter.parseDate(a)),
        );

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: sortedDates.length,
      itemBuilder: (context, index) {
        final dateString = sortedDates[index];
        final transactionsForDate = groupedTransactions[dateString]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                dateString,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            ...transactionsForDate.map(
              (tx) => TransactionItem(
                transaction: tx,
                onTap: () {
                  // Navigate to transaction details using GoRouter
                  AppRouter.goToTransactionDetail(tx['id'] as String);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
