import 'package:carful/src/domain/repair_area.dart';
import 'package:carful/src/domain/repair_attachment.dart';
import 'package:carful/src/domain/repair_entry.dart';
import 'package:carful/src/domain/repair_status.dart';
import 'package:carful/src/domain/repair_urgency.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String repairCollectionLabel(bool modifications) =>
    modifications ? 'Modifications' : 'Repairs';

String repairSingularLabel(bool modifications) =>
    modifications ? 'modification' : 'repair';

String formatRepairDate(DateTime date) => DateFormat.yMMMd().format(date);

String formatRepairTimestamp(RepairEntry entry) {
  final date = entry.isCompleted ? entry.completedAt : entry.updatedAt;
  if (date == null) {
    return '';
  }

  final label = entry.status == RepairStatus.completed
      ? 'Completed'
      : 'Updated';
  return '$label ${DateFormat.yMMMd().format(date)}';
}

String formatRepairUrgencyLabel(RepairUrgency urgency) =>
    '${urgency.label} urgency';

String repairTypeBadgeLabel(RepairEntry entry) =>
    entry.isModification ? 'Modification' : 'Repair';

IconData repairAreaIcon(RepairArea area) {
  switch (area) {
    case RepairArea.engine:
      return Icons.settings_rounded;
    case RepairArea.chassis:
      return Icons.car_repair_rounded;
    case RepairArea.body:
      return Icons.directions_car_filled_rounded;
    case RepairArea.suspension:
      return Icons.tire_repair_rounded;
    case RepairArea.electrics:
      return Icons.electrical_services_rounded;
    case RepairArea.interior:
      return Icons.airline_seat_recline_normal_rounded;
    case RepairArea.other:
      return Icons.build_circle_outlined;
  }
}

Color repairUrgencyColor(RepairUrgency urgency) {
  switch (urgency) {
    case RepairUrgency.low:
      return const Color(0xFF6C8566);
    case RepairUrgency.medium:
      return const Color(0xFFE4A633);
    case RepairUrgency.high:
      return const Color(0xFFBA1A1A);
  }
}

Color repairUrgencyBackground(RepairUrgency urgency) {
  switch (urgency) {
    case RepairUrgency.low:
      return const Color(0xFFDDECD7);
    case RepairUrgency.medium:
      return const Color(0xFFFFE1A9);
    case RepairUrgency.high:
      return const Color(0xFFFFDAD6);
  }
}

List<RepairAttachment> imageAttachments(List<RepairAttachment> attachments) {
  return attachments.where((attachment) => attachment.kind.isImage).toList();
}

List<RepairAttachment> fileAttachments(List<RepairAttachment> attachments) {
  return attachments.where((attachment) => !attachment.kind.isImage).toList();
}
