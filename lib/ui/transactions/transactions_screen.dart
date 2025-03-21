import 'package:flutter/material.dart';

import '../../routing/app_router.dart';
import '../core/themes/app_colors.dart';
import 'widgets/transaction_widgets.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String _selectedFilter = 'All';
  final TextEditingController _searchController = TextEditingController();

  // Sample transaction data
  final List<Map<String, dynamic>> _allTransactions = [
    {
      'id': 't1',
      'title': 'Grocery Shopping',
      'category': 'Food',
      'amount': -2400,
      'date': DateTime.now(),
      'icon': Icons.shopping_basket,
      'color': Colors.orange,
      'paymentMethod': 'Credit Card',
    },
    {
      'id': 't2',
      'title': 'Salary Deposit',
      'category': 'Income',
      'amount': 42500,
      'date': DateTime.now().subtract(const Duration(days: 1)),
      'icon': Icons.account_balance_wallet,
      'color': Colors.green,
      'paymentMethod': 'Bank Transfer',
    },
    {
      'id': 't3',
      'title': 'Electricity Bill',
      'category': 'Utilities',
      'amount': -1240,
      'date': DateTime.now().subtract(const Duration(days: 2)),
      'icon': Icons.bolt,
      'color': Colors.blue,
      'paymentMethod': 'UPI',
    },
    {
      'id': 't4',
      'title': 'Rent Payment',
      'category': 'Housing',
      'amount': -15000,
      'date': DateTime.now().subtract(const Duration(days: 5)),
      'icon': Icons.home,
      'color': Colors.indigo,
      'paymentMethod': 'Bank Transfer',
    },
    {
      'id': 't5',
      'title': 'Freelance Work',
      'category': 'Income',
      'amount': 8000,
      'date': DateTime.now().subtract(const Duration(days: 8)),
      'icon': Icons.work,
      'color': Colors.green,
      'paymentMethod': 'PayPal',
    },
    {
      'id': 't6',
      'title': 'Restaurant Dinner',
      'category': 'Food',
      'amount': -1800,
      'date': DateTime.now().subtract(const Duration(days: 10)),
      'icon': Icons.restaurant,
      'color': Colors.orange,
      'paymentMethod': 'Credit Card',
    },
    {
      'id': 't7',
      'title': 'Mobile Recharge',
      'category': 'Utilities',
      'amount': -499,
      'date': DateTime.now().subtract(const Duration(days: 12)),
      'icon': Icons.phone_android,
      'color': Colors.blue,
      'paymentMethod': 'UPI',
    },
    {
      'id': 't8',
      'title': 'Movie Tickets',
      'category': 'Entertainment',
      'amount': -600,
      'date': DateTime.now().subtract(const Duration(days: 15)),
      'icon': Icons.movie,
      'color': AppColors.cyclamen,
      'paymentMethod': 'Debit Card',
    },
  ];

  List<Map<String, dynamic>> _filteredTransactions = [];

  @override
  void initState() {
    super.initState();
    _filteredTransactions = _allTransactions;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterTransactions(String filter) {
    setState(() {
      _selectedFilter = filter;

      if (filter == 'All') {
        _filteredTransactions = _allTransactions;
      } else if (filter == 'Income') {
        _filteredTransactions =
            _allTransactions.where((tx) => tx['amount'] > 0).toList();
      } else if (filter == 'Expense') {
        _filteredTransactions =
            _allTransactions.where((tx) => tx['amount'] < 0).toList();
      } else {
        // Filter by category
        _filteredTransactions =
            _allTransactions.where((tx) => tx['category'] == filter).toList();
      }

      // Apply search if any
      if (_searchController.text.isNotEmpty) {
        _applySearch(_searchController.text);
      }
    });
  }

  void _applySearch(String query) {
    if (query.isEmpty) {
      _filterTransactions(_selectedFilter);
      return;
    }

    setState(() {
      _filteredTransactions =
          _filteredTransactions
              .where(
                (tx) =>
                    tx['title'].toLowerCase().contains(query.toLowerCase()) ||
                    tx['category'].toLowerCase().contains(
                      query.toLowerCase(),
                    ) ||
                    tx['paymentMethod'].toLowerCase().contains(
                      query.toLowerCase(),
                    ),
              )
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navigate to create transaction screen using GoRouter
              AppRouter.goToCreateTransaction();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          TransactionSearchBar(
            controller: _searchController,
            onSearch: _applySearch,
            onClear: () {
              _searchController.clear();
              _filterTransactions(_selectedFilter);
            },
          ),
          TransactionFilterChips(
            filters: const [
              'All',
              'Income',
              'Expense',
              'Food',
              'Utilities',
              'Housing',
              'Entertainment',
            ],
            selectedFilter: _selectedFilter,
            onFilterSelected: _filterTransactions,
          ),
          Expanded(
            child:
                _filteredTransactions.isEmpty
                    ? const EmptyTransactionsState()
                    : GroupedTransactionsList(
                      transactions: _filteredTransactions,
                    ),
          ),
        ],
      ),
    );
  }
}
