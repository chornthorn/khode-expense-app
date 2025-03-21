import 'package:flutter/material.dart';

import '../reports/reports_screen.dart';
import 'widgets/profile_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: Implement edit profile functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileHeader(
              name: 'Rahul Sharma',
              email: 'rahul.sharma@example.com',
              income: '\$42,500',
              expenses: '\$28,350',
              savings: '\$14,150',
            ),
            const SizedBox(height: 24),
            ProfileSectionHeader(title: 'Account'),
            AccountSettings(
              onPersonalInfoTap: () {
                // TODO: Navigate to personal info screen
              },
              onPaymentMethodsTap: () {
                // TODO: Navigate to payment methods screen
              },
              onCategoriesTap: () {
                // TODO: Navigate to categories screen
              },
              onSecurityTap: () {
                // TODO: Navigate to security screen
              },
            ),
            const SizedBox(height: 24),
            ProfileSectionHeader(title: 'Preferences'),
            PreferencesSettings(
              notificationsEnabled: true,
              biometricEnabled: false,
              autoSyncEnabled: true,
              onNotificationsChanged: (value) {
                // TODO: Update notification settings
              },
              onBiometricChanged: (value) {
                // TODO: Update biometric settings
              },
              onAutoSyncChanged: (value) {
                // TODO: Update sync settings
              },
            ),
            const SizedBox(height: 24),
            ProfileSectionHeader(title: 'App Settings'),
            AppSettings(
              currentLanguage: 'English (US)',
              currentCurrency: 'US Dollar (\$)',
              onLanguageTap: () {
                // TODO: Navigate to language settings
              },
              onCurrencyTap: () {
                // TODO: Navigate to currency settings
              },
              onReportsTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReportsScreen(),
                  ),
                );
              },
              onHelpAndSupportTap: () {
                // TODO: Navigate to help screen
              },
              onAboutTap: () {
                // TODO: Navigate to about screen
              },
            ),
            const SizedBox(height: 24),
            const LogoutButton(),
            const SizedBox(height: 16),
            VersionInfo(version: 'Khode Expense v1.0.0'),
          ],
        ),
      ),
    );
  }
}
