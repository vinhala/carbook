import 'package:carbook/src/app/router.dart';
import 'package:carbook/src/core/theme/app_theme.dart';
import 'package:carbook/src/data/local/app_database.dart';
import 'package:carbook/src/data/local/drift_assistant_repository.dart';
import 'package:carbook/src/data/local/drift_workshop_manual_repository.dart';
import 'package:carbook/src/features/ai/ai_assistant_controller.dart';
import 'package:carbook/src/domain/car_profile_repository.dart';
import 'package:carbook/src/domain/maintenance_repository.dart';
import 'package:carbook/src/domain/repair_repository.dart';
import 'package:carbook/src/domain/assistant_repository.dart';
import 'package:carbook/src/domain/workshop_manual_repository.dart';
import 'package:carbook/src/features/maintenance/maintenance_controller.dart';
import 'package:carbook/src/features/profile/car_profile_controller.dart';
import 'package:carbook/src/features/repairs/repair_controller.dart';
import 'package:carbook/src/services/ai_backend_service.dart';
import 'package:carbook/src/services/media_service.dart';
import 'package:carbook/src/services/reminder_scheduler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'test_doubles.dart';

ProviderScope buildTestApp({
  required AppDatabase database,
  required CarProfileRepository repository,
  required MaintenanceRepository maintenanceRepository,
  RepairRepository? repairRepository,
  WorkshopManualRepository? workshopManualRepository,
  AssistantRepository? assistantRepository,
  AiBackendService? aiBackendService,
  required MediaService mediaService,
  required ReminderScheduler reminderScheduler,
  bool allowRuntimeFontFetching = false,
}) {
  GoogleFonts.config.allowRuntimeFetching = allowRuntimeFontFetching;
  final router = AppRouter.createRouter();
  final resolvedRepairRepository =
      repairRepository ?? DriftRepairRepository(database);
  final resolvedWorkshopManualRepository =
      workshopManualRepository ?? DriftWorkshopManualRepository(database);
  final resolvedAssistantRepository =
      assistantRepository ?? DriftAssistantRepository(database);
  final resolvedAiBackendService = aiBackendService ?? FakeAiBackendService();

  return ProviderScope(
    overrides: [
      appDatabaseProvider.overrideWithValue(database),
      carProfileRepositoryProvider.overrideWithValue(repository),
      maintenanceRepositoryProvider.overrideWithValue(maintenanceRepository),
      repairRepositoryProvider.overrideWithValue(resolvedRepairRepository),
      workshopManualRepositoryProvider.overrideWithValue(
        resolvedWorkshopManualRepository,
      ),
      assistantRepositoryProvider.overrideWithValue(
        resolvedAssistantRepository,
      ),
      aiBackendServiceProvider.overrideWithValue(resolvedAiBackendService),
      mediaServiceProvider.overrideWithValue(mediaService),
      reminderSchedulerProvider.overrideWithValue(reminderScheduler),
      carProfileControllerProvider.overrideWithValue(
        CarProfileController(
          repository: repository,
          workshopManualRepository: resolvedWorkshopManualRepository,
          aiBackendService: resolvedAiBackendService,
          mediaService: mediaService,
          reminderScheduler: reminderScheduler,
        ),
      ),
      maintenanceControllerProvider.overrideWithValue(
        MaintenanceController(repository: maintenanceRepository),
      ),
      repairControllerProvider.overrideWithValue(
        RepairController(
          repository: resolvedRepairRepository,
          mediaService: mediaService,
        ),
      ),
      aiAssistantControllerProvider.overrideWithValue(
        AiAssistantController(
          carProfileRepository: repository,
          maintenanceRepository: maintenanceRepository,
          repairRepository: resolvedRepairRepository,
          workshopManualRepository: resolvedWorkshopManualRepository,
          assistantRepository: resolvedAssistantRepository,
          aiBackendService: resolvedAiBackendService,
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
