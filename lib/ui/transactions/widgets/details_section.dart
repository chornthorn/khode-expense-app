import 'package:flutter/material.dart';

import 'detail_item.dart';

class DetailsSection extends StatelessWidget {
  final Map<String, dynamic> transaction;
  final String formattedDate;

  const DetailsSection({
    super.key,
    required this.transaction,
    required this.formattedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Details', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              DetailItem(
                label: 'Date',
                value: formattedDate,
                icon: Icons.calendar_today_outlined,
              ),
              const Divider(height: 1),
              DetailItem(
                label: 'Payment Method',
                value: transaction['paymentMethod'] as String,
                icon: Icons.payment,
              ),
              const Divider(height: 1),
              DetailItem(
                label: 'Category',
                value: transaction['category'] as String,
                icon: Icons.category_outlined,
              ),
              const Divider(height: 1),
              DetailItem(
                label: 'Transaction ID',
                value: transaction['id'] as String,
                icon: Icons.tag,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
