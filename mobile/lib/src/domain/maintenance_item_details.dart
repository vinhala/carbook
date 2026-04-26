import 'package:carful/src/domain/maintenance_due_status.dart';
import 'package:carful/src/domain/maintenance_item.dart';
import 'package:carful/src/domain/maintenance_log_entry.dart';

class MaintenanceItemDetails {
  const MaintenanceItemDetails({
    required this.item,
    required this.dueStatus,
    required this.logs,
  });

  final MaintenanceItem item;
  final MaintenanceDueStatus dueStatus;
  final List<MaintenanceLogEntry> logs;
}
