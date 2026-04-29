import 'package:carful/src/domain/maintenance_time_unit.dart';
import 'package:carful/src/domain/mileage_reminder_frequency.dart';
import 'package:carful/src/domain/repair_area.dart';
import 'package:carful/src/domain/repair_urgency.dart';
import 'package:carful/src/l10n/generated/app_localizations.dart';
import 'package:flutter/widgets.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

extension MileageReminderFrequencyL10n on MileageReminderFrequency {
  String localizedLabel(AppLocalizations l10n) => switch (this) {
    MileageReminderFrequency.weekly => l10n.weekly,
    MileageReminderFrequency.monthly => l10n.monthly,
    MileageReminderFrequency.quarterly => l10n.quarterly,
    MileageReminderFrequency.never => l10n.never,
  };
}

extension MaintenanceTimeUnitL10n on MaintenanceTimeUnit {
  String localizedLabel(AppLocalizations l10n) => switch (this) {
    MaintenanceTimeUnit.weeks => l10n.weeks,
    MaintenanceTimeUnit.months => l10n.months,
    MaintenanceTimeUnit.years => l10n.years,
  };

  String localizedInterval(AppLocalizations l10n, int value) => switch (this) {
    MaintenanceTimeUnit.weeks => l10n.week(value),
    MaintenanceTimeUnit.months => l10n.month(value),
    MaintenanceTimeUnit.years => l10n.year(value),
  };
}

extension RepairAreaL10n on RepairArea {
  String localizedLabel(AppLocalizations l10n) => switch (this) {
    RepairArea.engine => l10n.engineArea,
    RepairArea.chassis => l10n.chassisArea,
    RepairArea.body => l10n.bodyArea,
    RepairArea.suspension => l10n.suspensionArea,
    RepairArea.electrics => l10n.electricsArea,
    RepairArea.interior => l10n.interiorArea,
    RepairArea.other => l10n.otherArea,
  };
}

extension RepairUrgencyL10n on RepairUrgency {
  String localizedLabel(AppLocalizations l10n) => switch (this) {
    RepairUrgency.low => l10n.low,
    RepairUrgency.medium => l10n.medium,
    RepairUrgency.high => l10n.high,
  };
}
