import 'package:flutter/material.dart';

import '../../core/themes/app_colors.dart';

class AmountInputField extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  const AmountInputField({super.key, required this.controller, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headlineMedium,
      decoration: InputDecoration(
        hintText: '0.00',
        border: InputBorder.none,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(top: 6.0, right: 4),
          child: Text(
            '\$',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
      ),
      validator: validator,
    );
  }
}
