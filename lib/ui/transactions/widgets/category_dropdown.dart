import 'package:flutter/material.dart';

import '../../core/themes/app_colors.dart';

class CategoryDropdown extends StatelessWidget {
  final String value;
  final List<String> categories;
  final Map<String, IconData> categoryIcons;
  final Map<String, Color> categoryColors;
  final ValueChanged<String?> onChanged;

  const CategoryDropdown({
    super.key,
    required this.value,
    required this.categories,
    required this.categoryIcons,
    required this.categoryColors,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: const InputDecoration(
        labelText: 'Category',
        prefixIcon: Icon(Icons.category_outlined),
      ),
      items:
          categories.map((category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Row(
                children: [
                  Icon(
                    categoryIcons[category] ?? Icons.category_outlined,
                    color: categoryColors[category] ?? AppColors.textSecondary,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Text(category),
                ],
              ),
            );
          }).toList(),
      onChanged: onChanged,
    );
  }
}
