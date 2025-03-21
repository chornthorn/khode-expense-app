import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onViewAllPressed;

  const SectionHeader({
    super.key,
    required this.title,
    required this.onViewAllPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Make the section header adapt to screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style:
              isSmallScreen
                  ? Theme.of(context).textTheme.titleMedium
                  : Theme.of(context).textTheme.titleLarge,
        ),
        TextButton(
          onPressed: onViewAllPressed,
          child: Text(
            'View All',
            style: TextStyle(fontSize: isSmallScreen ? 12 : 14),
          ),
        ),
      ],
    );
  }
}
