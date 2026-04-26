import 'package:carful/src/domain/maintenance_due_status.dart';
import 'package:carful/src/domain/maintenance_item.dart';

class MaintenanceScheduleEntry {
  const MaintenanceScheduleEntry({required this.item, required this.dueStatus});

  final MaintenanceItem item;
  final MaintenanceDueStatus dueStatus;
}
