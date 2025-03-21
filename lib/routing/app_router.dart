import 'route_constants.dart';
import 'router_config.dart';

/// Helper class for navigation throughout the app
class AppRouter {
  /// Navigate to main nav (home screen with bottom tabs)
  static void goToMainNav() {
    AppRouterSingleton.instance.go(RouteConstants.mainNav);
  }

  /// Navigate to dashboard
  static void goToDashboard() {
    AppRouterSingleton.instance.go(RouteConstants.dashboard);
  }

  /// Navigate to transactions list
  static void goToTransactions() {
    AppRouterSingleton.instance.go(RouteConstants.transactions);
  }

  /// Navigate to transaction detail
  static void goToTransactionDetail(String id) {
    final path = RouteConstants.transactionDetail.replaceAll(':id', id);
    AppRouterSingleton.instance.push(path);
  }

  /// Navigate to create transaction
  static void goToCreateTransaction() {
    AppRouterSingleton.instance.go(RouteConstants.createTransaction);
  }

  /// Navigate to edit transaction
  static void goToEditTransaction(String id) {
    final path = RouteConstants.editTransaction.replaceAll(':id', id);
    AppRouterSingleton.instance.go(path);
  }

  /// Navigate to budget
  static void goToBudget() {
    AppRouterSingleton.instance.go(RouteConstants.budget);
  }

  /// Navigate to category detail
  static void goToCategoryDetail(String id) {
    final path = RouteConstants.categoryDetail.replaceAll(':id', id);
    AppRouterSingleton.instance.go(path);
  }

  /// Navigate to profile
  static void goToProfile() {
    AppRouterSingleton.instance.go(RouteConstants.profile);
  }

  /// Navigate to reports
  static void goToReports() {
    AppRouterSingleton.instance.go(RouteConstants.reports);
  }

  /// Navigate back
  static void goBack() {
    AppRouterSingleton.instance.pop();
  }
}
