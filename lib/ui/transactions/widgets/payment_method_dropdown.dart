import 'package:flutter/material.dart';

class PaymentMethodDropdown extends StatelessWidget {
  final String value;
  final List<String> paymentMethods;
  final ValueChanged<String?> onChanged;

  const PaymentMethodDropdown({
    super.key,
    required this.value,
    required this.paymentMethods,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: const InputDecoration(
        labelText: 'Payment Method',
        prefixIcon: Icon(Icons.payment),
      ),
      items:
          paymentMethods.map((method) {
            return DropdownMenuItem<String>(value: method, child: Text(method));
          }).toList(),
      onChanged: onChanged,
    );
  }
}
