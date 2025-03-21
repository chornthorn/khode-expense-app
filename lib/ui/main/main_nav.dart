import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../budget/budget_screen.dart';
import '../dashboard/dashboard_screen.dart';
import '../profile/profile_screen.dart';
import '../transactions/transactions_screen.dart';
import '../core/themes/app_colors.dart';

class MainNav extends StatefulWidget {
  const MainNav({super.key});

  @override
  State<MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int _selectedIndex = 0;

  // List of pages to be shown when a nav item is selected
  final List<Widget> _pages = [
    const DashboardScreen(),
    const TransactionsScreen(),
    const BudgetScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: PhosphorIcon(
              PhosphorIconsDuotone.houseSimple,
              color: AppColors.textSecondary,
              duotoneSecondaryOpacity: 0.6,
              duotoneSecondaryColor: AppColors.textSecondary.withValues(
                alpha: 0.3,
              ),
            ),
            activeIcon: PhosphorIcon(
              PhosphorIconsDuotone.houseSimple,
              color: AppColors.cyclamen,
              duotoneSecondaryOpacity: 0.6,
              duotoneSecondaryColor: AppColors.cyclamen.withValues(alpha: 0.3),
            ),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: PhosphorIcon(
              PhosphorIconsDuotone.arrowsLeftRight,
              color: AppColors.textSecondary,
              duotoneSecondaryOpacity: 0.6,
              duotoneSecondaryColor: AppColors.textSecondary.withValues(
                alpha: 0.3,
              ),
            ),
            activeIcon: PhosphorIcon(
              PhosphorIconsDuotone.arrowsLeftRight,
              color: AppColors.cyclamen,
              duotoneSecondaryOpacity: 0.6,
              duotoneSecondaryColor: AppColors.cyclamen.withValues(alpha: 0.3),
            ),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: PhosphorIcon(
              PhosphorIconsDuotone.wallet,
              color: AppColors.textSecondary,
              duotoneSecondaryOpacity: 0.6,
              duotoneSecondaryColor: AppColors.textSecondary.withValues(
                alpha: 0.3,
              ),
            ),
            activeIcon: PhosphorIcon(
              PhosphorIconsDuotone.wallet,
              color: AppColors.cyclamen,
              duotoneSecondaryOpacity: 0.6,
              duotoneSecondaryColor: AppColors.cyclamen.withValues(alpha: 0.3),
            ),
            label: 'Budget',
          ),
          BottomNavigationBarItem(
            icon: PhosphorIcon(
              PhosphorIconsDuotone.user,
              color: AppColors.textSecondary,
              duotoneSecondaryOpacity: 0.6,
              duotoneSecondaryColor: AppColors.textSecondary.withValues(
                alpha: 0.3,
              ),
            ),
            activeIcon: PhosphorIcon(
              PhosphorIconsDuotone.user,
              color: AppColors.cyclamen,
              duotoneSecondaryOpacity: 0.6,
              duotoneSecondaryColor: AppColors.cyclamen.withValues(alpha: 0.3),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
