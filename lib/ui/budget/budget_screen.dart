import 'package:flutter/material.dart';

import '../core/themes/app_colors.dart';
import 'category_detail_screen.dart';
import 'widgets/budget_widgets.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  // Sample budget data
  final Map<String, dynamic> _monthlyBudget = {
    'totalBudget': 50000,
    'totalSpent': 28350,
    'month': 'March',
    'year': '2024',
    'categories': [
      {
        'name': 'Food & Groceries',
        'budget': 15000,
        'spent': 12400,
        'icon': Icons.restaurant,
        'color': Colors.orange,
      },
      {
        'name': 'Housing',
        'budget': 20000,
        'spent': 15000,
        'icon': Icons.home,
        'color': Colors.indigo,
      },
      {
        'name': 'Transportation',
        'budget': 5000,
        'spent': 3200,
        'icon': Icons.directions_car,
        'color': Colors.blue,
      },
      {
        'name': 'Utilities',
        'budget': 3000,
        'spent': 1739,
        'icon': Icons.bolt,
        'color': Colors.amber,
      },
      {
        'name': 'Entertainment',
        'budget': 6000,
        'spent': 4800,
        'icon': Icons.movie,
        'color': AppColors.cyclamen,
      },
      {
        'name': 'Shopping',
        'budget': 8000,
        'spent': 2500,
        'icon': Icons.shopping_bag,
        'color': Colors.green,
      },
      {
        'name': 'Health',
        'budget': 4000,
        'spent': 1200,
        'icon': Icons.local_hospital,
        'color': Colors.red,
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          BudgetAppBar(
            monthlyBudget: _monthlyBudget,
            onNavigateToPreviousMonth: () {
              // TODO: Navigate to previous month
            },
            onNavigateToNextMonth: () {
              // TODO: Navigate to next month
            },
            onCalendarPressed: () {
              // TODO: Show month picker
            },
            onMoreOptionsPressed: () {
              // TODO: Show more options
            },
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TotalBudgetCard(
                  totalBudget: _monthlyBudget['totalBudget'],
                  totalSpent: _monthlyBudget['totalSpent'],
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SectionHeader(
                    title: 'Budget Breakdown',
                    onFilterPressed: _showFilterOptions,
                  ),
                ),
                const SizedBox(height: 16),
                _buildCategoryList(),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildSetBudgetButton(),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show modal for adding a new budget category
          _showAddCategoryModal();
        },
        backgroundColor: AppColors.cyclamen,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildCategoryList() {
    final categories = _monthlyBudget['categories'] as List;

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];

        return CategoryListItem(
          category: category,
          onTap: (category) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CategoryDetailScreen(category: category),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSetBudgetButton() {
    return ElevatedButton.icon(
      onPressed: () {
        // Show budget adjustment modal
        _showAdjustBudgetModal();
      },
      icon: const Icon(Icons.edit_outlined),
      label: const Text('Adjust Budget Limits'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _showAddCategoryModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 20,
            left: 20,
            right: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add New Category',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Category Name',
                  prefixIcon: Icon(Icons.category_outlined),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Budget Amount',
                  prefixIcon: Icon(Icons.attach_money),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Add Category'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  void _showAdjustBudgetModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Adjust Budget',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Monthly Budget',
                  prefixIcon: Icon(Icons.attach_money),
                ),
                keyboardType: TextInputType.number,
                controller: TextEditingController(
                  text: (_monthlyBudget['totalBudget'] / 100).toStringAsFixed(
                    0,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Save Changes'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Filter Budget Categories',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  BudgetFilterChip(
                    label: 'All Categories',
                    isSelected: true, // For demo
                    onSelected: (selected) {
                      // Update filter
                    },
                  ),
                  BudgetFilterChip(
                    label: 'Over Budget',
                    isSelected: false,
                    onSelected: (selected) {
                      // Update filter
                    },
                  ),
                  BudgetFilterChip(
                    label: 'Almost Full',
                    isSelected: false,
                    onSelected: (selected) {
                      // Update filter
                    },
                  ),
                  BudgetFilterChip(
                    label: 'On Track',
                    isSelected: false,
                    onSelected: (selected) {
                      // Update filter
                    },
                  ),
                  BudgetFilterChip(
                    label: 'Just Started',
                    isSelected: false,
                    onSelected: (selected) {
                      // Update filter
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Apply'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
