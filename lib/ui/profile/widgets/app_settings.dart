import 'package:flutter/material.dart';

import 'settings_tile.dart';

class AppSettings extends StatelessWidget {
  final String currentLanguage;
  final String currentCurrency;
  final VoidCallback onLanguageTap;
  final VoidCallback onCurrencyTap;
  final VoidCallback onReportsTap;
  final VoidCallback onHelpAndSupportTap;
  final VoidCallback onAboutTap;

  const AppSettings({
    super.key,
    required this.currentLanguage,
    required this.currentCurrency,
    required this.onLanguageTap,
    required this.onCurrencyTap,
    required this.onReportsTap,
    required this.onHelpAndSupportTap,
    required this.onAboutTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          SettingsTile(
            icon: Icons.language,
            title: 'Language',
            subtitle: currentLanguage,
            onTap: onLanguageTap,
            showTrailingIcon: true,
          ),
          const Divider(height: 1),
          SettingsTile(
            icon: Icons.attach_money,
            title: 'Currency',
            subtitle: currentCurrency,
            onTap: onCurrencyTap,
            showTrailingIcon: true,
          ),
          const Divider(height: 1),
          SettingsTile(
            icon: Icons.bar_chart,
            title: 'Reports',
            subtitle: 'View your financial reports and analytics',
            onTap: onReportsTap,
          ),
          const Divider(height: 1),
          SettingsTile(
            icon: Icons.help_outline,
            title: 'Help & Support',
            subtitle: 'Get assistance and contact support',
            onTap: onHelpAndSupportTap,
          ),
          const Divider(height: 1),
          SettingsTile(
            icon: Icons.info_outline,
            title: 'About',
            subtitle: 'Terms, privacy, and app information',
            onTap: onAboutTap,
          ),
        ],
      ),
    );
  }
}
