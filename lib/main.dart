import 'package:carbook/src/app/app.dart';
import 'package:carbook/src/data/local/app_database.dart';
import 'package:carbook/src/features/maintenance/maintenance_controller.dart';
import 'package:carbook/src/features/profile/car_profile_controller.dart';
import 'package:carbook/src/features/repairs/repair_controller.dart';
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
  final plugin = FlutterLocalNotificationsPlugin();
  final notificationClient = FlutterLocalNotificationsClient(plugin);
  await notificationClient.initialize();
  await notificationClient.requestPermissions();

  final reminderScheduler = RollingReminderScheduler(notificationClient);
  final mediaService = DeviceMediaService();
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
        repairControllerProvider.overrideWithValue(
          RepairController(
            repository: repairRepository,
            mediaService: mediaService,
          ),
        ),
      ],
      child: const CarbookApp(),
    ),
  );
}
