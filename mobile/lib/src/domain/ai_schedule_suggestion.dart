import 'package:carful/src/domain/maintenance_item_input.dart';
import 'package:carful/src/domain/maintenance_schedule_type.dart';
import 'package:carful/src/domain/maintenance_time_unit.dart';

class AiScheduleSuggestion {
  const AiScheduleSuggestion({
    required this.title,
    required this.description,
    required this.scheduleType,
    required this.intervalValue,
    required this.timeUnit,
    required this.priority,
    required this.manualReference,
    required this.selectedByDefault,
  });

  final String title;
  final String description;
  final String scheduleType;
  final int intervalValue;
  final String? timeUnit;
  final String priority;
  final String? manualReference;
  final bool selectedByDefault;

  MaintenanceItemInput toMaintenanceItemInput() {
    final normalizedType = scheduleType.toLowerCase();
    final isTimeBased = normalizedType == 'time';
    return MaintenanceItemInput(
      description: title,
      scheduleType: isTimeBased
          ? MaintenanceScheduleType.time
          : MaintenanceScheduleType.distance,
      intervalValue: intervalValue,
      timeUnit: isTimeBased ? _parseTimeUnit(timeUnit) : null,
    );
  }

  MaintenanceTimeUnit _parseTimeUnit(String? value) {
    switch ((value ?? '').toLowerCase()) {
      case 'month':
      case 'months':
        return MaintenanceTimeUnit.months;
      case 'year':
      case 'years':
        return MaintenanceTimeUnit.years;
      case 'week':
      case 'weeks':
      default:
        return MaintenanceTimeUnit.weeks;
    }
  }
}
