import 'package:flutter/material.dart';

import '../../core/themes/app_colors.dart';
import 'profile_stat.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final String income;
  final String expenses;
  final String savings;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    required this.income,
    required this.expenses,
    required this.savings,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: AppColors.cyclamen,
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
          const SizedBox(height: 16),
          Text(
            name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(email, style: TextStyle(fontSize: 16, color: Colors.grey[400])),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProfileStat(value: income, label: 'Income'),
              Container(
                height: 30,
                width: 1,
                color: AppColors.divider,
                margin: const EdgeInsets.symmetric(horizontal: 16),
              ),
              ProfileStat(value: expenses, label: 'Expenses'),
              Container(
                height: 30,
                width: 1,
                color: AppColors.divider,
                margin: const EdgeInsets.symmetric(horizontal: 16),
              ),
              ProfileStat(value: savings, label: 'Savings'),
            ],
          ),
        ],
      ),
    );
  }
}
