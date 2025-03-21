import 'package:flutter/material.dart';

import 'switch_tile.dart';

class PreferencesSettings extends StatelessWidget {
  final bool notificationsEnabled;
  final bool biometricEnabled;
  final bool autoSyncEnabled;
  final Function(bool) onNotificationsChanged;
  final Function(bool) onBiometricChanged;
  final Function(bool) onAutoSyncChanged;

  const PreferencesSettings({
    super.key,
    required this.notificationsEnabled,
    required this.biometricEnabled,
    required this.autoSyncEnabled,
    required this.onNotificationsChanged,
    required this.onBiometricChanged,
    required this.onAutoSyncChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          ProfileSwitchTile(
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            subtitle: 'Receive alerts and reminders',
            value: notificationsEnabled,
            onChanged: onNotificationsChanged,
          ),
          const Divider(height: 1),
          ProfileSwitchTile(
            icon: Icons.fingerprint,
            title: 'Biometric Authentication',
            subtitle: 'Use fingerprint or face ID for login',
            value: biometricEnabled,
            onChanged: onBiometricChanged,
          ),
          const Divider(height: 1),
          ProfileSwitchTile(
            icon: Icons.cloud_upload_outlined,
            title: 'Auto Sync',
            subtitle: 'Sync data automatically',
            value: autoSyncEnabled,
            onChanged: onAutoSyncChanged,
          ),
        ],
      ),
    );
  }
}
