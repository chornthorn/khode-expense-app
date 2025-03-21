import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/services/auth_service.dart';
import '../ui/auth/login_screen.dart';
import '../ui/budget/budget_screen.dart';
import '../ui/budget/category_detail_screen.dart';
import '../ui/dashboard/dashboard_screen.dart';
import '../ui/main/main_nav.dart';
import '../ui/profile/profile_screen.dart';
import '../ui/reports/reports_screen.dart';
import '../ui/splash/animated_splash_screen.dart';
import '../ui/transactions/create_transaction_screen.dart';
import '../ui/transactions/transaction_detail_screen.dart';
import '../ui/transactions/transactions_screen.dart';
import 'route_constants.dart';

/// Navigation helper to access router from anywhere (without BuildContext)
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

/// AppRouter singleton class
class AppRouterSingleton {
  static GoRouter? _instance;
  static AuthService? _authService;

  /// Get the GoRouter instance
  static GoRouter get instance {
    assert(_instance != null, 'Router must be initialized before use');
    return _instance!;
  }

  /// Initialize the router with an AuthService
  static void initialize(AuthService authService) {
    // Only initialize if not already initialized or if auth service changed
    if (_instance == null || _authService != authService) {
      _authService = authService;
      _instance = _createRouter(authService);
    }
  }

  /// Create the router configuration
  static GoRouter _createRouter(AuthService authService) {
    return GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: RouteConstants.splash,
      debugLogDiagnostics: true,

      // Add refresh listener to rebuild routes when auth state changes
      refreshListenable: authService,

      // Redirect logic for authentication
      redirect: (BuildContext context, GoRouterState state) {
        final bool isLoggedIn = authService.isSignedIn();
        final bool isAuthRoute =
            state.matchedLocation == RouteConstants.login ||
            state.matchedLocation == RouteConstants.register ||
            state.matchedLocation == RouteConstants.forgotPassword;
        final bool isSplashRoute =
            state.matchedLocation == RouteConstants.splash;

        debugPrint(
          'GoRouter redirect: isLoggedIn=$isLoggedIn, location=${state.matchedLocation}',
        );

        // Always allow splash screen
        if (isSplashRoute) {
          return null;
        }

        // If not logged in and not on an auth route, redirect to login
        if (!isLoggedIn && !isAuthRoute) {
          return RouteConstants.login;
        }

        // If logged in and on an auth route, redirect to main nav
        if (isLoggedIn && isAuthRoute) {
          return RouteConstants.mainNav;
        }

        // No redirect needed
        return null;
      },

      // Routes configuration
      routes: [
        // Splash screen
        GoRoute(
          path: RouteConstants.splash,
          builder: (context, state) => const AnimatedSplashScreen(),
        ),

        // Auth routes
        GoRoute(
          path: RouteConstants.login,
          builder: (context, state) => const LoginScreen(),
        ),

        // Main navigation container (contains the bottom navigation)
        GoRoute(
          path: RouteConstants.mainNav,
          builder: (context, state) => const MainNav(),
        ),

        // Individual screens (some accessed directly, some through MainNav)
        GoRoute(
          path: RouteConstants.dashboard,
          builder: (context, state) => const DashboardScreen(),
        ),

        // Transaction routes
        GoRoute(
          path: RouteConstants.transactions,
          builder: (context, state) => const TransactionsScreen(),
        ),
        GoRoute(
          path: RouteConstants.transactionDetail,
          builder: (context, state) {
            // Extract the transaction ID from the URL
            final transactionId = state.pathParameters['id'] ?? '';

            // In a real app, you would fetch the transaction by ID from a service
            // This is a simple example that passes a dummy transaction
            final transaction = {
              'id': transactionId,
              'title': 'Transaction $transactionId',
              'category': 'Food',
              'amount': -2400,
              'date': DateTime.now(),
              'icon': Icons.shopping_basket,
              'color': Colors.orange,
              'paymentMethod': 'Credit Card',
            };

            return TransactionDetailScreen(transaction: transaction);
          },
        ),
        GoRoute(
          path: RouteConstants.createTransaction,
          builder: (context, state) => const CreateTransactionScreen(),
        ),

        // Budget routes
        GoRoute(
          path: RouteConstants.budget,
          builder: (context, state) => const BudgetScreen(),
        ),
        GoRoute(
          path: RouteConstants.categoryDetail,
          builder: (context, state) {
            // Extract the category ID from the URL
            final categoryId = state.pathParameters['id'] ?? '';

            // In a real app, you would fetch the category by ID from a service
            // This is a simple example that passes a dummy category
            final category = {
              'name': 'Category $categoryId',
              'budget': 15000,
              'spent': 12400,
              'icon': Icons.restaurant,
              'color': Colors.orange,
            };

            return CategoryDetailScreen(category: category);
          },
        ),

        // Profile route
        GoRoute(
          path: RouteConstants.profile,
          builder: (context, state) => const ProfileScreen(),
        ),

        // Reports route
        GoRoute(
          path: RouteConstants.reports,
          builder: (context, state) => const ReportsScreen(),
        ),
      ],
    );
  }
}

/// GoRouter instance for use throughout the app (initialized in main.dart)
late final GoRouter appRouter;
