import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/sign_in_screen.dart';
import '../../data/services/auth_service.dart';
import 'main_nav.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    // Decide which screen to show based on authentication state
    return authService.isAuthenticated ? const MainNav() : const SignInScreen();
  }
}
