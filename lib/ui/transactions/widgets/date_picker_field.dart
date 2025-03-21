import 'package:flutter/material.dart';

import '../../core/themes/app_colors.dart';

class DatePickerField extends StatelessWidget {
  final TextEditingController controller;
  final DateTime initialDate;
  final ValueChanged<DateTime> onDateChanged;

  const DatePickerField({
    super.key,
    required this.controller,
    required this.initialDate,
    required this.onDateChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: const InputDecoration(
        labelText: 'Date',
        prefixIcon: Icon(Icons.calendar_today_outlined),
      ),
      onTap: () async {
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: DateTime(2000),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.dark(
                  primary: AppColors.cyclamen,
                  onPrimary: Colors.white,
                  surface: AppColors.cardBackground,
                  onSurface: AppColors.textPrimary,
                ),
              ),
              child: child!,
            );
          },
        );

        if (pickedDate != null) {
          onDateChanged(pickedDate);
        }
      },
    );
  }
}
