import 'package:carbook/src/app/app.dart';
import 'package:carbook/src/data/local/app_database.dart';
import 'package:carbook/src/data/local/drift_assistant_repository.dart';
import 'package:carbook/src/data/local/drift_workshop_manual_repository.dart';
import 'package:carbook/src/features/ai/ai_assistant_controller.dart';
import 'package:carbook/src/features/maintenance/maintenance_controller.dart';
import 'package:carbook/src/features/profile/car_profile_controller.dart';
import 'package:carbook/src/features/repairs/repair_controller.dart';
import 'package:carbook/src/services/ai_backend_service.dart';
import 'package:carbook/src/services/media_service.dart';
import 'package:carbook/src/services/reminder_scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();

  final database = AppDatabase();
  final repository = DriftCarProfileRepository(database);
  final maintenanceRepository = DriftMaintenanceRepository(database);
  final repairRepository = DriftRepairRepository(database);
  final workshopManualRepository = DriftWorkshopManualRepository(database);
  final assistantRepository = DriftAssistantRepository(database);
  final plugin = FlutterLocalNotificationsPlugin();
  final notificationClient = FlutterLocalNotificationsClient(plugin);
  await notificationClient.initialize();
  await notificationClient.requestPermissions();

  final reminderScheduler = RollingReminderScheduler(notificationClient);
  final mediaService = DeviceMediaService();
  final aiBackendService = HttpAiBackendService();
  final profiles = await repository.watchProfiles().first;
  for (final profile in profiles) {
    await reminderScheduler.syncForProfile(profile);
  }

  runApp(
    ProviderScope(
      overrides: [
        appDatabaseProvider.overrideWithValue(database),
        carProfileRepositoryProvider.overrideWithValue(repository),
        maintenanceRepositoryProvider.overrideWithValue(maintenanceRepository),
        repairRepositoryProvider.overrideWithValue(repairRepository),
        workshopManualRepositoryProvider.overrideWithValue(
          workshopManualRepository,
        ),
        assistantRepositoryProvider.overrideWithValue(assistantRepository),
        aiBackendServiceProvider.overrideWithValue(aiBackendService),
        mediaServiceProvider.overrideWithValue(mediaService),
        reminderSchedulerProvider.overrideWithValue(reminderScheduler),
        carProfileControllerProvider.overrideWithValue(
          CarProfileController(
            repository: repository,
            workshopManualRepository: workshopManualRepository,
            aiBackendService: aiBackendService,
            mediaService: mediaService,
            reminderScheduler: reminderScheduler,
          ),
        ),
        maintenanceControllerProvider.overrideWithValue(
          MaintenanceController(repository: maintenanceRepository),
        ),
        repairControllerProvider.overrideWithValue(
          RepairController(
            repository: repairRepository,
            mediaService: mediaService,
          ),
        ),
        aiAssistantControllerProvider.overrideWithValue(
          AiAssistantController(
            carProfileRepository: repository,
            maintenanceRepository: maintenanceRepository,
            repairRepository: repairRepository,
            workshopManualRepository: workshopManualRepository,
            assistantRepository: assistantRepository,
            aiBackendService: aiBackendService,
          ),
        ),
      ],
      child: const CarbookApp(),
    ),
  );
}
