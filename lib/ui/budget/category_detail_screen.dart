import 'package:flutter/material.dart';

import '../core/themes/app_colors.dart';

class CategoryDetailScreen extends StatefulWidget {
  final Map<String, dynamic> category;

  const CategoryDetailScreen({super.key, required this.category});

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  bool _isEditing = false;
  late TextEditingController _budgetController;

  // Sample transaction data for this category
  final List<Map<String, dynamic>> _transactions = [];

  @override
  void initState() {
    super.initState();
    _budgetController = TextEditingController(
      text: (widget.category['budget'] as int).toString(),
    );

    // Generate sample transactions based on the category
    _generateSampleTransactions();
  }

  void _generateSampleTransactions() {
    final categoryName = widget.category['name'] as String;
    final spent = widget.category['spent'] as int;

    // Create 4-7 transactions that add up to the total spent amount
    int remaining = spent;
    final count = 4 + (spent % 4); // Between 4 and 7 transactions
    final now = DateTime.now();

    for (int i = 0; i < count; i++) {
      // Last transaction gets whatever is left
      final amount =
          i == count - 1
              ? remaining
              : (remaining ~/ (count - i)) + (50 * (i + 1));

      remaining -= amount;

      final daysAgo = i * 2 + (i % 3); // Spread out over recent days

      _transactions.add({
        'title': _getTransactionTitle(categoryName, i),
        'amount': -amount, // Negative for expenses
        'date': now.subtract(Duration(days: daysAgo)),
        'icon': widget.category['icon'],
        'color': widget.category['color'],
        'paymentMethod': _getRandomPaymentMethod(i),
      });
    }

    // Sort by date, newest first
    _transactions.sort(
      (a, b) => (b['date'] as DateTime).compareTo(a['date'] as DateTime),
    );
  }

  String _getTransactionTitle(String category, int index) {
    // Generate plausible transaction titles based on category
    switch (category) {
      case 'Food & Groceries':
        final places = [
          'Whole Foods',
          'Trader Joe\'s',
          'Safeway',
          'Local Market',
          'Costco',
        ];
        return '${places[index % places.length]} Shopping';
      case 'Housing':
        return index == 0 ? 'Monthly Rent' : 'Utilities Payment';
      case 'Transportation':
        final items = [
          'Gas Station',
          'Car Repair',
          'Parking Fee',
          'Uber Ride',
          'Public Transit',
        ];
        return items[index % items.length];
      case 'Utilities':
        final bills = [
          'Electricity Bill',
          'Water Bill',
          'Internet Bill',
          'Gas Bill',
          'Phone Bill',
        ];
        return bills[index % bills.length];
      case 'Entertainment':
        final activities = [
          'Movie Tickets',
          'Concert',
          'Streaming Service',
          'App Store',
          'Game Purchase',
        ];
        return activities[index % activities.length];
      case 'Shopping':
        final stores = [
          'Amazon',
          'Target',
          'Mall',
          'Department Store',
          'Electronics Store',
        ];
        return '${stores[index % stores.length]} Purchase';
      case 'Health':
        final items = [
          'Pharmacy',
          'Doctor Visit',
          'Gym Membership',
          'Health Insurance',
          'Vitamins',
        ];
        return items[index % items.length];
      default:
        return 'Transaction #${index + 1}';
    }
  }

  String _getRandomPaymentMethod(int index) {
    final methods = [
      'Credit Card',
      'Debit Card',
      'Cash',
      'Bank Transfer',
      'Mobile Payment',
    ];
    return methods[index % methods.length];
  }

  @override
  void dispose() {
    _budgetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final category = widget.category;
    final budget = category['budget'] as int;
    final spent = category['spent'] as int;
    final percentage = spent / budget;
    final remaining = budget - spent;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(category, percentage),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBudgetHeader(budget, spent, remaining, percentage),
                _buildDivider(),
                _buildDailyBreakdown(budget, spent, percentage),
                _buildDivider(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: Text(
                    'Recent Transactions',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                _buildTransactionsList(),
                const SizedBox(height: 80), // Space for FAB
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // For now, toggle between view/edit mode
          setState(() {
            if (_isEditing) {
              // Save changes
              final newBudget = int.tryParse(_budgetController.text) ?? budget;
              if (newBudget != budget) {
                // Would update in a real app
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Budget updated successfully')),
                );
              }
            }
            _isEditing = !_isEditing;
          });
        },
        backgroundColor: AppColors.cyclamen,
        icon: Icon(_isEditing ? Icons.check : Icons.edit),
        label: Text(_isEditing ? 'Save' : 'Edit Budget'),
      ),
    );
  }

  Widget _buildAppBar(Map<String, dynamic> category, double percentage) {
    return SliverAppBar(
      expandedHeight: 160,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                (category['color'] as Color).withOpacity(0.8),
                (category['color'] as Color),
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(72, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category['name'] as String,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildStatusChip(percentage),
                ],
              ),
            ),
          ),
        ),
        titlePadding: const EdgeInsets.all(16),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'delete') {
              _showDeleteConfirmation();
            }
          },
          itemBuilder:
              (context) => [
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete_outline, color: Colors.redAccent),
                      SizedBox(width: 8),
                      Text('Delete Category'),
                    ],
                  ),
                ),
              ],
        ),
      ],
    );
  }

  Widget _buildStatusChip(double percentage) {
    String text;
    Color color;
    Color textColor = Colors.white;

    if (percentage >= 1.0) {
      text = 'Over Budget';
      color = Colors.redAccent;
    } else if (percentage >= 0.9) {
      text = 'Almost Full';
      color = Colors.orange;
    } else if (percentage <= 0.25) {
      text = 'Just Started';
      color = Colors.green;
    } else {
      text = 'On Track';
      color = AppColors.turquoise;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildBudgetHeader(
    int budget,
    int spent,
    int remaining,
    double percentage,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child:
          _isEditing
              ? _buildBudgetEditForm(budget)
              : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Budget',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: AppColors.textSecondary),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '\$${budget.toStringAsFixed(0)}',
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Remaining',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: AppColors.textSecondary),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '\$${remaining.toStringAsFixed(0)}',
                            style: Theme.of(
                              context,
                            ).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color:
                                  remaining < 0
                                      ? Colors.redAccent
                                      : Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: percentage.clamp(
                      0.0,
                      1.0,
                    ), // Clamp to show max 100% in the bar
                    backgroundColor: AppColors.divider,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _getColorForPercentage(percentage),
                    ),
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Spent: \$${spent.toStringAsFixed(0)}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${(percentage * 100).toInt()}% of budget',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: _getColorForPercentage(percentage),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
    );
  }

  Widget _buildBudgetEditForm(int currentBudget) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Adjust Budget', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 16),
        TextField(
          controller: _budgetController,
          decoration: const InputDecoration(
            labelText: 'Monthly Budget Amount',
            prefixIcon: Icon(Icons.attach_money),
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          autofocus: true,
        ),
        const SizedBox(height: 8),
        Text(
          'Tap the Save button below when done',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondary,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  Widget _buildDailyBreakdown(int budget, int spent, double percentage) {
    // Calculate daily stats
    final daysInMonth =
        DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day;
    final currentDay = DateTime.now().day;

    final dailyBudget = budget / daysInMonth;
    final dailySpent = spent / currentDay;
    final dailyIdeal = budget * (currentDay / daysInMonth);
    final dailyStatus = spent <= dailyIdeal ? 'under' : 'over';

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Daily Breakdown',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDailyStatCard(
                'Daily Budget',
                '\$${dailyBudget.round()}',
                Icons.calendar_today,
                AppColors.cyclamen,
              ),
              _buildDailyStatCard(
                'Avg. Spent/Day',
                '\$${dailySpent.round()}',
                Icons.show_chart,
                dailyStatus == 'under' ? Colors.green : Colors.redAccent,
              ),
              _buildDailyStatCard(
                'Days Left',
                '${daysInMonth - currentDay}',
                Icons.access_time,
                AppColors.turquoise,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'You are ${dailyStatus == 'under' ? 'under' : 'over'} your ideal spending by \$${(dailyIdeal - spent).abs().round()}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: dailyStatus == 'under' ? Colors.green : Colors.redAccent,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.27,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsList() {
    if (_transactions.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(
                Icons.receipt_long,
                size: 48,
                color: AppColors.textSecondary.withOpacity(0.5),
              ),
              const SizedBox(height: 16),
              Text(
                'No transactions for this category yet',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _transactions.length,
      itemBuilder: (context, index) {
        final transaction = _transactions[index];
        return _buildTransactionItem(transaction, index);
      },
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> transaction, int index) {
    final date = transaction['date'] as DateTime;
    final formattedDate = _formatDate(date);
    final amount = transaction['amount'] as int;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: (transaction['color'] as Color).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            transaction['icon'] as IconData,
            color: transaction['color'] as Color,
          ),
        ),
        title: Text(transaction['title'] as String),
        subtitle: Text(
          '${transaction['paymentMethod']} • $formattedDate',
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
        ),
        trailing: Text(
          '\$${amount.abs()}',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: amount > 0 ? Colors.green : null,
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 1, thickness: 1, indent: 16, endIndent: 16);
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Delete Category'),
            content: Text(
              'Are you sure you want to delete the ${widget.category['name']} category? All associated transactions will be preserved but will no longer be categorized.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  Navigator.pop(context); // Go back to budget screen

                  // Show confirmation
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Category deleted')),
                  );
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
            ],
          ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateToCheck = DateTime(date.year, date.month, date.day);

    if (dateToCheck == today) {
      return 'Today';
    } else if (dateToCheck == yesterday) {
      return 'Yesterday';
    } else {
      return '${date.day} ${months[date.month - 1]}';
    }
  }

  Color _getColorForPercentage(double percentage) {
    if (percentage >= 1.0) {
      return Colors.redAccent;
    } else if (percentage >= 0.9) {
      return Colors.orange;
    } else if (percentage >= 0.75) {
      return Colors.amber;
    } else {
      return AppColors.cyclamen;
    }
  }
}
