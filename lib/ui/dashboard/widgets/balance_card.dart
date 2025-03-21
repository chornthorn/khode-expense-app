import 'package:flutter/material.dart';

import '../../core/themes/app_colors.dart';
import 'dashboard_card_item.dart';

class BalanceCard extends StatelessWidget {
  final String totalBalance;
  final String month;
  final String year;
  final String income;
  final String expenses;
  final String savingsPercentage;

  const BalanceCard({
    super.key,
    required this.totalBalance,
    required this.month,
    required this.year,
    required this.income,
    required this.expenses,
    required this.savingsPercentage,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsive sizing
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate card height based on screen width
    final cardHeight = screenWidth * 0.55;
    final isSmallScreen = screenWidth < 360;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      width: double.infinity,
      height: cardHeight.clamp(180.0, 240.0),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.cyclamen, AppColors.amethyst],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(isSmallScreen ? 16.0 : 20.0),
            child: Column(
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
                          'Total Balance',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(color: Colors.white.withOpacity(0.8)),
                        ),
                        SizedBox(height: isSmallScreen ? 4 : 8),
                        Text(
                          totalBalance,
                          style:
                              isSmallScreen
                                  ? Theme.of(
                                    context,
                                  ).textTheme.headlineSmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  )
                                  : Theme.of(
                                    context,
                                  ).textTheme.displaySmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 8 : 12,
                        vertical: isSmallScreen ? 4 : 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        '$month $year',
                        style: Theme.of(
                          context,
                        ).textTheme.labelLarge?.copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                LayoutBuilder(
                  builder: (context, constraints) {
                    // If width is less than a certain threshold, use a more compact layout
                    if (constraints.maxWidth < 300) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DashboardCardItem(
                                title: 'Income',
                                amount: income,
                                icon: Icons.arrow_downward,
                                isSmallScreen: isSmallScreen,
                              ),
                              DashboardCardItem(
                                title: 'Expenses',
                                amount: expenses,
                                icon: Icons.arrow_upward,
                                isSmallScreen: isSmallScreen,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          DashboardCardItem(
                            title: 'Savings',
                            amount: savingsPercentage,
                            icon: Icons.savings_outlined,
                            isSmallScreen: isSmallScreen,
                          ),
                        ],
                      );
                    }

                    // Default layout for normal sized screens
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DashboardCardItem(
                          title: 'Income',
                          amount: income,
                          icon: Icons.arrow_downward,
                          isSmallScreen: isSmallScreen,
                        ),
                        DashboardCardItem(
                          title: 'Expenses',
                          amount: expenses,
                          icon: Icons.arrow_upward,
                          isSmallScreen: isSmallScreen,
                        ),
                        DashboardCardItem(
                          title: 'Savings',
                          amount: savingsPercentage,
                          icon: Icons.savings_outlined,
                          isSmallScreen: isSmallScreen,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
