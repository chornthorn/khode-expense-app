import 'package:flutter/material.dart';

import '../../routing/app_router.dart';
import 'widgets/transaction_widgets.dart';

class TransactionDetailScreen extends StatelessWidget {
  final Map<String, dynamic> transaction;

  const TransactionDetailScreen({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final date = transaction['date'] as DateTime;
    final formattedDate = TransactionDateFormatter.formatDateDetailed(date);

    // Example for demo purposes (would come from transaction data in production)
    final hasNotes = transaction['id'] == 't1' || transaction['id'] == 't4';
    final noteText =
        transaction['id'] == 't1'
            ? 'Weekly grocery shopping at Whole Foods. Bought ingredients for the dinner party on Saturday.'
            : 'Monthly rent payment for apartment.';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Navigate to edit transaction using GoRouter
              AppRouter.goToEditTransaction(transaction['id'] as String);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              _showDeleteConfirmation(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TransactionHeader(transaction: transaction),
            const SizedBox(height: 32),
            DetailsSection(
              transaction: transaction,
              formattedDate: formattedDate,
            ),
            const SizedBox(height: 32),
            NotesSection(
              notes: hasNotes ? noteText : null,
              onEditTap: () {
                // TODO: Implement note editing
              },
            ),
            const SizedBox(height: 32),
            AttachmentsSection(
              onAddAttachment: () {
                // TODO: Implement add attachment
              },
            ),
            const SizedBox(height: 32),
            TransactionActionButtons(
              transaction: transaction,
              onDuplicate: () {
                // For duplicating, we'll still navigate to the same transaction
                // In a real app, you would create a new transaction with the same details
                AppRouter.goToTransactionDetail(transaction['id'] as String);
              },
              onSplit: () {
                // Show split transaction UI (not implemented in this demo)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Split transaction feature coming soon'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Delete Transaction'),
            content: const Text(
              'Are you sure you want to delete this transaction? This action cannot be undone.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  // Navigate back to transactions list using GoRouter
                  AppRouter.goToTransactions();
                  // Show deletion confirmation
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Transaction deleted')),
                  );
                },
                child: Text(
                  'Delete',
                  style: TextStyle(color: Colors.redAccent.shade700),
                ),
              ),
            ],
          ),
    );
  }
}
