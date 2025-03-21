import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/services/auth_service.dart';
import 'routing/router_config.dart';
import 'ui/core/themes/app_colors.dart';
import 'ui/core/themes/app_theme.dart';

void main() {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    // Only use DevicePreview in web
    kIsWeb
        ? DevicePreview(
          enabled: true,
          isToolbarVisible: false,
          backgroundColor: AppColors.cardBackground,
          defaultDevice: DeviceInfo.genericPhone(
            platform: TargetPlatform.iOS,
            id: 'iphone-13-pro-max',
            name: 'iPhone 13 Pro Max',
            screenSize: Size(428, 926),
            safeAreas: EdgeInsets.zero,
            pixelRatio: 3.0,
            framePainter: GenericPhoneFramePainter(),
          ),
          builder: (context) => const KhodeExpenseApp(),
        )
        : const KhodeExpenseApp(),
  );
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
