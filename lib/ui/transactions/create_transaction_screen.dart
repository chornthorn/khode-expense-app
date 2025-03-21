import 'package:flutter/material.dart';

import '../../routing/app_router.dart';
import '../core/themes/app_colors.dart';
import 'widgets/transaction_widgets.dart';

class CreateTransactionScreen extends StatefulWidget {
  const CreateTransactionScreen({super.key});

  @override
  State<CreateTransactionScreen> createState() =>
      _CreateTransactionScreenState();
}

class _CreateTransactionScreenState extends State<CreateTransactionScreen> {
  final _formKey = GlobalKey<FormState>();

  // Transaction type (income or expense)
  bool _isExpense = true;

  // Form controllers
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();
  final _notesController = TextEditingController();

  // Selected values
  String _selectedCategory = 'Food';
  String _selectedPaymentMethod = 'Credit Card';
  DateTime _selectedDate = DateTime.now();

  // Categories and payment methods (would come from a central data source in a real app)
  final List<String> _categories = [
    'Food',
    'Transportation',
    'Housing',
    'Utilities',
    'Entertainment',
    'Shopping',
    'Health',
    'Education',
    'Income',
  ];

  final List<String> _paymentMethods = [
    'Credit Card',
    'Debit Card',
    'Cash',
    'Bank Transfer',
    'UPI',
    'PayPal',
  ];

  // Category icons map
  final Map<String, IconData> _categoryIcons = {
    'Food': Icons.restaurant,
    'Transportation': Icons.directions_car,
    'Housing': Icons.home,
    'Utilities': Icons.bolt,
    'Entertainment': Icons.movie,
    'Shopping': Icons.shopping_bag,
    'Health': Icons.local_hospital,
    'Education': Icons.school,
    'Income': Icons.account_balance_wallet,
  };

  // Category colors map
  final Map<String, Color> _categoryColors = {
    'Food': Colors.orange,
    'Transportation': Colors.blue,
    'Housing': Colors.indigo,
    'Utilities': Colors.amber,
    'Entertainment': AppColors.cyclamen,
    'Shopping': Colors.green,
    'Health': Colors.red,
    'Education': Colors.purple,
    'Income': Colors.green,
  };

  @override
  void initState() {
    super.initState();
    _dateController.text = TransactionDateFormatter.formatDateCompact(
      _selectedDate,
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _dateController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isExpense ? 'Add Expense' : 'Add Income'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => AppRouter.goBack(),
        ),
        actions: [
          TextButton.icon(
            onPressed: _saveTransaction,
            icon: const Icon(Icons.check),
            label: const Text('Save'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TransactionTypeSwitch(
                  isExpense: _isExpense,
                  onExpenseChanged:
                      (value) => setState(() => _isExpense = value),
                ),
                const SizedBox(height: 24),
                AmountInputField(
                  controller: _amountController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an amount';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _titleController,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    hintText: 'e.g., Grocery Shopping',
                    prefixIcon: Icon(Icons.title),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                CategoryDropdown(
                  value: _selectedCategory,
                  categories: _categories,
                  categoryIcons: _categoryIcons,
                  categoryColors: _categoryColors,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedCategory = value;
                        // Auto-switch to income if Income category is selected
                        if (value == 'Income') {
                          _isExpense = false;
                        }
                      });
                    }
                  },
                ),
                const SizedBox(height: 24),
                PaymentMethodDropdown(
                  value: _selectedPaymentMethod,
                  paymentMethods: _paymentMethods,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedPaymentMethod = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 24),
                DatePickerField(
                  controller: _dateController,
                  initialDate: _selectedDate,
                  onDateChanged: (date) {
                    setState(() {
                      _selectedDate = date;
                      _dateController.text =
                          TransactionDateFormatter.formatDateCompact(date);
                    });
                  },
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _notesController,
                  maxLines: 3,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    labelText: 'Notes (Optional)',
                    hintText: 'Add additional details...',
                    prefixIcon: Icon(Icons.note_outlined),
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: 24),
                TransactionSaveButton(
                  isExpense: _isExpense,
                  onPressed: _saveTransaction,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveTransaction() {
    if (_formKey.currentState!.validate()) {
      // In a real app, this would save to a database or state management solution

      // Create transaction object
      final newTransaction = {
        'id': 'tx_${DateTime.now().millisecondsSinceEpoch}',
        'title': _titleController.text,
        'category': _selectedCategory,
        'amount': (_isExpense ? -1 : 1) * double.parse(_amountController.text),
        'date': _selectedDate,
        'paymentMethod': _selectedPaymentMethod,
        'notes': _notesController.text,
        'icon': _categoryIcons[_selectedCategory] ?? Icons.category_outlined,
        'color': _categoryColors[_selectedCategory] ?? AppColors.textSecondary,
      };

      // For demo purposes, just print the transaction and return to previous screen
      debugPrint('New transaction: $newTransaction');

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isExpense
                ? 'Expense added successfully'
                : 'Income added successfully',
          ),
          backgroundColor: _isExpense ? Colors.redAccent : Colors.green,
        ),
      );

      // Return to the previous screen
      AppRouter.goToTransactions();
    }
  }
}
