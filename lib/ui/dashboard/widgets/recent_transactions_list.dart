import 'package:flutter/material.dart';

import '../../core/themes/app_colors.dart';
import '../../transactions/transaction_detail_screen.dart';

class RecentTransactionsList extends StatelessWidget {
  final List<Map<String, dynamic>> transactions;

  const RecentTransactionsList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsive sizing
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children:
              transactions.map((transaction) {
                // Prepare a full transaction object
                final dashboardTransaction = {
                  ...transaction,
                  // Convert string amount to integer (remove $ and ,)
                  'amount':
                      -double.parse(
                        transaction['amount']
                            .toString()
                            .replaceAll('\$', '')
                            .replaceAll(',', ''),
                      ).toInt(),
                  'date': transaction['date_obj'],
                };

                return Card(
                  margin: EdgeInsets.only(bottom: isSmallScreen ? 8 : 12),
                  child: InkWell(
                    onTap: () {
                      // Navigate to transaction details
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => TransactionDetailScreen(
                                transaction: dashboardTransaction,
                              ),
                        ),
                      );
                    },
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 12 : 16,
                        vertical: isSmallScreen ? 6 : 8,
                      ),
                      leading: Container(
                        padding: EdgeInsets.all(isSmallScreen ? 8 : 10),
                        decoration: BoxDecoration(
                          color: (transaction['color'] as Color).withOpacity(
                            0.1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          transaction['icon'] as IconData,
                          color: transaction['color'] as Color,
                          size: isSmallScreen ? 18 : 24,
                        ),
                      ),
                      title: Text(
                        transaction['title'] as String,
                        style: TextStyle(
                          fontSize: isSmallScreen ? 14 : 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        transaction['category'] as String,
                        style: TextStyle(
                          fontSize: isSmallScreen ? 12 : 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            transaction['amount'] as String,
                            style: TextStyle(
                              fontSize: isSmallScreen ? 14 : 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            transaction['date'] as String,
                            style: TextStyle(
                              fontSize: isSmallScreen ? 11 : 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
        );
      },
    );
  }
}
