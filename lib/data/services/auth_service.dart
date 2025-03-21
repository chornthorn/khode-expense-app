import 'package:flutter/material.dart';

/// Authentication service
class AuthService extends ChangeNotifier {
  bool _isAuthenticated = false;

  AuthService() {
    // Initialize auth state - could check for stored tokens or credentials
    _initializeAuthState();
  }

  // Check for stored credentials on startup
  Future<void> _initializeAuthState() async {
    // This would typically check for stored tokens or credentials
    // For demo, we'll just set it to false initially
    _isAuthenticated = false;
    notifyListeners();
  }

  bool get isAuthenticated => _isAuthenticated;

  /// Returns true if the user is currently signed in
  bool isSignedIn() => _isAuthenticated;

  Future<bool> signIn(String email, String password) async {
    // Simulated authentication
    // In a real app, this would make an API call to your backend

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // For demo purposes, any non-empty email/password combination works
    if (email.isNotEmpty && password.isNotEmpty) {
      _isAuthenticated = true;
      notifyListeners(); // Important: Notify listeners to trigger router refresh
      return true;
    }

    return false;
  }

  Future<bool> signInWithSocial(String provider) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // In a real app, this would connect to the social auth provider
    _isAuthenticated = true;
    notifyListeners(); // Important: Notify listeners to trigger router refresh
    return true;
  }

  Future<void> signOut() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    _isAuthenticated = false;
    notifyListeners(); // Important: Notify listeners to trigger router refresh
  }
}
