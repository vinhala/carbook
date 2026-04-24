import 'package:carbook/src/app/router.dart';
import 'package:carbook/src/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CarbookApp extends StatelessWidget {
  const CarbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Carbook',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}
