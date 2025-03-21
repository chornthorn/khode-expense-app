import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onFilterPressed;

  const SectionHeader({super.key, required this.title, this.onFilterPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(title, style: Theme.of(context).textTheme.titleLarge),
        ),
        if (onFilterPressed != null)
          TextButton.icon(
            onPressed: onFilterPressed,
            icon: const Icon(Icons.filter_list, size: 18),
            label: const Text('Filter'),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            ),
          ),
      ],
    );
  }
}
