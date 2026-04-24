import 'package:carbook/src/domain/maintenance_item_details.dart';
import 'package:carbook/src/domain/maintenance_item_input.dart';
import 'package:carbook/src/domain/maintenance_log_input.dart';
import 'package:carbook/src/domain/maintenance_schedule_entry.dart';

abstract class MaintenanceRepository {
  Stream<List<MaintenanceScheduleEntry>> watchSchedule(int carProfileId);
  Stream<MaintenanceItemDetails?> watchMaintenanceItem(int itemId);
  Future<int> createItem(int carProfileId, MaintenanceItemInput input);
  Future<void> addPerformedWork(int itemId, MaintenanceLogInput input);
}
