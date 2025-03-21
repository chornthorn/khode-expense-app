import 'package:flutter/material.dart';

class DashboardCardItem extends StatelessWidget {
  final String title;
  final String amount;
  final IconData icon;
  final bool isSmallScreen;

  const DashboardCardItem({
    super.key,
    required this.title,
    required this.amount,
    required this.icon,
    required this.isSmallScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(isSmallScreen ? 8 : 10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: isSmallScreen ? 20 : 24),
        ),
        SizedBox(height: isSmallScreen ? 4 : 8),
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: Colors.white.withOpacity(0.8)),
        ),
        SizedBox(height: isSmallScreen ? 2 : 4),
        Text(
          amount,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: isSmallScreen ? 13 : null,
          ),
        ),
      ],
    );
  }
}
