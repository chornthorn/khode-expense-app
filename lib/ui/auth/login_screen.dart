import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/services/auth_service.dart';
import '../../routing/app_router.dart';
import 'sign_in_screen.dart';

/// Login screen - Renamed SignInScreen for better compatibility with routes
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  // For testing direct login
  Future<void> _testDirectLogin() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    setState(() {
      _isLoading = true;
    });

    try {
      // Use a default login for testing
      final success = await authService.signIn(
        'test@example.com',
        'password123',
      );

      // Explicitly navigate to main_nav after successful login for testing
      if (success && mounted) {
        // GoRouter should handle this automatically, but we can force it for testing
        AppRouter.goToMainNav();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Login error: ${e.toString()}')));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // The regular sign-in screen
          const SignInScreen(),

          // Loading indicator overlay
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(child: CircularProgressIndicator()),
            ),

          // Debug button for direct login (only in debug mode)
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: Colors.amber,
              mini: true,
              onPressed: _testDirectLogin,
              child: const Icon(Icons.login),
            ),
          ),
        ],
      ),
    );
  }
}
