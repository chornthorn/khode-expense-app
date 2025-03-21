import 'package:flutter/material.dart';

import '../../core/themes/app_colors.dart';

class DashboardHeader extends StatelessWidget {
  final String username;
  final VoidCallback onNotificationsPressed;

  const DashboardHeader({
    super.key,
    required this.username,
    required this.onNotificationsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, $username!',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                'Welcome back',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: onNotificationsPressed,
          ),
        ],
      ),
    );
  }
}
