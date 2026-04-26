import 'package:carful/src/app/router.dart';
import 'package:carful/src/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CarfulApp extends StatelessWidget {
  const CarfulApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Carful',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}
