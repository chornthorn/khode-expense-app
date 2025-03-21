import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/services/auth_service.dart';
import 'routing/router_config.dart';
import 'ui/core/themes/app_theme.dart';

void main() {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const KhodeExpenseApp());
}

class KhodeExpenseApp extends StatelessWidget {
  const KhodeExpenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthService(),
      child: Builder(
        builder: (context) {
          final authService = Provider.of<AuthService>(context);

          AppRouterSingleton.initialize(authService);

          return MaterialApp.router(
            title: 'Khode Expense',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.darkTheme,
            routerConfig: AppRouterSingleton.instance,
          );
        },
      ),
    );
  }
}
