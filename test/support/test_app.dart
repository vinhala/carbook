import 'package:carbook/src/app/router.dart';
import 'package:carbook/src/core/theme/app_theme.dart';
import 'package:carbook/src/data/local/app_database.dart';
import 'package:carbook/src/domain/car_profile_repository.dart';
import 'package:carbook/src/features/profile/car_profile_controller.dart';
import 'package:carbook/src/services/media_service.dart';
import 'package:carbook/src/services/reminder_scheduler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

ProviderScope buildTestApp({
  required AppDatabase database,
  required CarProfileRepository repository,
  required MediaService mediaService,
  required ReminderScheduler reminderScheduler,
}) {
  GoogleFonts.config.allowRuntimeFetching = false;
  final router = AppRouter.createRouter();

  return ProviderScope(
    overrides: [
      appDatabaseProvider.overrideWithValue(database),
      carProfileRepositoryProvider.overrideWithValue(repository),
      mediaServiceProvider.overrideWithValue(mediaService),
      reminderSchedulerProvider.overrideWithValue(reminderScheduler),
      carProfileControllerProvider.overrideWithValue(
        CarProfileController(
          repository: repository,
          mediaService: mediaService,
          reminderScheduler: reminderScheduler,
        ),
      ),
    ],
    child: MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: router,
    ),
  );
}
