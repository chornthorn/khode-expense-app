import 'package:flutter/material.dart';

import '../budget/budget_screen.dart';
import '../core/themes/app_colors.dart';
import '../transactions/create_transaction_screen.dart';
import '../transactions/transactions_screen.dart';
import 'widgets/dashboard_widgets.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy transaction data
    final transactions = [
      {
        'title': 'Grocery Shopping',
        'category': 'Food',
        'amount': '\$2,400',
        'date': 'Today',
        'icon': Icons.shopping_basket,
        'color': Colors.orange,
        'id': 'recent1',
        'paymentMethod': 'Credit Card',
        'date_obj': DateTime.now(),
      },
      {
        'title': 'Electricity Bill',
        'category': 'Utilities',
        'amount': '\$1,240',
        'date': 'Yesterday',
        'icon': Icons.bolt,
        'color': Colors.blue,
        'id': 'recent2',
        'paymentMethod': 'Bank Transfer',
        'date_obj': DateTime.now().subtract(const Duration(days: 1)),
      },
      {
        'title': 'Rent Payment',
        'category': 'Housing',
        'amount': '\$15,000',
        'date': '22 Mar',
        'icon': Icons.home,
        'color': Colors.green,
        'id': 'recent3',
        'paymentMethod': 'Bank Transfer',
        'date_obj': DateTime.now().subtract(const Duration(days: 5)),
      },
    ];

    // Dummy budget data
    final budgets = [
      {
        'category': 'Food & Groceries',
        'spent': 12400,
        'total': 15000,
        'icon': Icons.restaurant,
        'color': Colors.orange,
      },
      {
        'category': 'Transportation',
        'spent': 3200,
        'total': 5000,
        'icon': Icons.directions_car,
        'color': Colors.blue,
      },
      {
        'category': 'Entertainment',
        'spent': 4800,
        'total': 6000,
        'icon': Icons.movie,
        'color': AppColors.cyclamen,
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DashboardHeader(
                username: 'User',
                onNotificationsPressed: () {
                  // TODO: Implement notifications
                },
              ),
              BalanceCard(
                totalBalance: '\$14,150',
                month: 'March',
                year: '2024',
                income: '\$42,500',
                expenses: '\$28,350',
                savingsPercentage: '33%',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionHeader(
                      title: 'Recent Transactions',
                      onViewAllPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TransactionsScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    RecentTransactionsList(transactions: transactions),
                    const SizedBox(height: 20),
                    SectionHeader(
                      title: 'Budget Overview',
                      onViewAllPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BudgetScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    BudgetOverviewList(budgets: budgets),
                    // Add bottom padding for scroll safety
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateTransactionScreen(),
            ),
          );
        },
        backgroundColor: AppColors.cyclamen,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
