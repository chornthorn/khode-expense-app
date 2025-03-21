/// Constants for route names
class RouteConstants {
  // Splash screen
  static const String splash = '/splash';

  // Auth routes
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';

  // Main nav route (container for main tabs)
  static const String mainNav = '/';

  // Main routes
  static const String dashboard = '/dashboard';
  static const String transactions = '/transactions';
  static const String transactionDetail = '/transactions/:id';
  static const String createTransaction = '/transactions/create';
  static const String editTransaction = '/transactions/:id/edit';

  // Budget routes
  static const String budget = '/budget';
  static const String categoryDetail = '/budget/category/:id';

  // Profile routes
  static const String profile = '/profile';
  static const String settings = '/settings';

  // Report routes
  static const String reports = '/reports';
}
