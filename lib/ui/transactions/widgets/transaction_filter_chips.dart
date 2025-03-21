import 'package:flutter/material.dart';

import '../../core/themes/app_colors.dart';

class TransactionFilterChips extends StatelessWidget {
  final List<String> filters;
  final String selectedFilter;
  final Function(String) onFilterSelected;

  const TransactionFilterChips({
    super.key,
    required this.filters,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FilterChip(
              label: Text(filter),
              selected: selectedFilter == filter,
              onSelected: (selected) {
                if (selected) {
                  onFilterSelected(filter);
                }
              },
              backgroundColor: AppColors.inputBackground,
              selectedColor: AppColors.cyclamen.withOpacity(0.2),
              checkmarkColor: AppColors.cyclamen,
              labelStyle: TextStyle(
                color:
                    selectedFilter == filter
                        ? AppColors.cyclamen
                        : AppColors.textPrimary,
              ),
            ),
          );
        },
      ),
    );
  }
}
