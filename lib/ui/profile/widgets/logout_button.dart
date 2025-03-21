import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/services/auth_service.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        // Show a confirmation dialog before logging out
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text('Confirm Logout'),
                content: const Text('Are you sure you want to log out?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close dialog
                      // Call the logout method from AuthService
                      Provider.of<AuthService>(
                        context,
                        listen: false,
                      ).signOut();
                    },
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                    child: const Text('Log Out'),
                  ),
                ],
              ),
        );
      },
      icon: const Icon(Icons.exit_to_app),
      label: const Text('Log Out'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
      ),
    );
  }
}
