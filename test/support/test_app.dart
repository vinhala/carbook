import 'package:carbook/src/app/router.dart';
import 'package:carbook/src/core/theme/app_theme.dart';
import 'package:carbook/src/data/local/app_database.dart';
import 'package:carbook/src/domain/car_profile_repository.dart';
import 'package:carbook/src/domain/maintenance_repository.dart';
import 'package:carbook/src/features/maintenance/maintenance_controller.dart';
import 'package:carbook/src/features/profile/car_profile_controller.dart';
import 'package:carbook/src/services/media_service.dart';
import 'package:carbook/src/services/reminder_scheduler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

ProviderScope buildTestApp({
  required AppDatabase database,
  required CarProfileRepository repository,
  required MaintenanceRepository maintenanceRepository,
  required MediaService mediaService,
  required ReminderScheduler reminderScheduler,
  bool allowRuntimeFontFetching = false,
}) {
  GoogleFonts.config.allowRuntimeFetching = allowRuntimeFontFetching;
  final router = AppRouter.createRouter();

  return ProviderScope(
    overrides: [
      appDatabaseProvider.overrideWithValue(database),
      carProfileRepositoryProvider.overrideWithValue(repository),
      maintenanceRepositoryProvider.overrideWithValue(maintenanceRepository),
      mediaServiceProvider.overrideWithValue(mediaService),
      reminderSchedulerProvider.overrideWithValue(reminderScheduler),
      carProfileControllerProvider.overrideWithValue(
        CarProfileController(
          repository: repository,
          mediaService: mediaService,
          reminderScheduler: reminderScheduler,
        ),
      ),
      maintenanceControllerProvider.overrideWithValue(
        MaintenanceController(repository: maintenanceRepository),
      ),
    ],
    child: MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: router,
    ),
  );
}
