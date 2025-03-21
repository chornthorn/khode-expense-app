import 'package:flutter/material.dart';

import '../../core/themes/app_colors.dart';

/// Utility functions for budget-related widgets
class BudgetUtils {
  /// Returns a color based on the percentage of budget spent
  static Color getColorForPercentage(double percentage) {
    if (percentage >= 1.0) {
      return Colors.redAccent;
    } else if (percentage >= 0.9) {
      return Colors.orange;
    } else if (percentage >= 0.75) {
      return Colors.amber;
    } else {
      return AppColors.cyclamen;
    }
  }
}
