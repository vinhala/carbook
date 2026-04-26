import 'package:carful/src/data/local/app_database.dart';
import 'package:carful/src/domain/maintenance_item_details.dart';
import 'package:carful/src/domain/maintenance_item_input.dart';
import 'package:carful/src/domain/maintenance_repository.dart';
import 'package:carful/src/domain/maintenance_schedule_entry.dart';
import 'package:carful/src/domain/maintenance_log_input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final maintenanceControllerProvider = Provider<MaintenanceController>(
  (ref) => MaintenanceController(
    repository: ref.watch(maintenanceRepositoryProvider),
  ),
);

final maintenanceScheduleProvider =
    StreamProvider.family<List<MaintenanceScheduleEntry>, int>(
      (ref, carId) =>
          ref.watch(maintenanceRepositoryProvider).watchSchedule(carId),
    );

final maintenanceItemProvider =
    StreamProvider.family<MaintenanceItemDetails?, int>(
      (ref, itemId) =>
          ref.watch(maintenanceRepositoryProvider).watchMaintenanceItem(itemId),
    );

class MaintenanceController {
  const MaintenanceController({required this.repository});

  final MaintenanceRepository repository;

  Future<int> createItem(int carProfileId, MaintenanceItemInput input) {
    return repository.createItem(carProfileId, input);
  }

  Future<void> updateItem(int itemId, MaintenanceItemInput input) {
    return repository.updateItem(itemId, input);
  }

  Future<void> deleteItem(int itemId) {
    return repository.deleteItem(itemId);
  }

  Future<void> addPerformedWork(int itemId, MaintenanceLogInput input) {
    return repository.addPerformedWork(itemId, input);
  }
}
