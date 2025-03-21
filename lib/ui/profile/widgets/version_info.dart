import 'package:flutter/material.dart';

import '../../core/themes/app_colors.dart';

class VersionInfo extends StatelessWidget {
  final String version;

  const VersionInfo({super.key, required this.version});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        version,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
      ),
    );
  }
}
