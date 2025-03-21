import 'package:flutter/material.dart';

import 'settings_tile.dart';

class AccountSettings extends StatelessWidget {
  final VoidCallback onPersonalInfoTap;
  final VoidCallback onPaymentMethodsTap;
  final VoidCallback onCategoriesTap;
  final VoidCallback onSecurityTap;

  const AccountSettings({
    super.key,
    required this.onPersonalInfoTap,
    required this.onPaymentMethodsTap,
    required this.onCategoriesTap,
    required this.onSecurityTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          SettingsTile(
            icon: Icons.person_outline,
            title: 'Personal Information',
            subtitle: 'Update your personal details',
            onTap: onPersonalInfoTap,
          ),
          const Divider(height: 1),
          SettingsTile(
            icon: Icons.credit_card,
            title: 'Payment Methods',
            subtitle: 'Add or remove payment options',
            onTap: onPaymentMethodsTap,
          ),
          const Divider(height: 1),
          SettingsTile(
            icon: Icons.category_outlined,
            title: 'Categories',
            subtitle: 'Customize expense categories',
            onTap: onCategoriesTap,
          ),
          const Divider(height: 1),
          SettingsTile(
            icon: Icons.lock_outline,
            title: 'Security',
            subtitle: 'Update password and security settings',
            onTap: onSecurityTap,
          ),
        ],
      ),
    );
  }
}
